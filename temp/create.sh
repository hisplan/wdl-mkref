#!/bin/bash -x

ensembl_ver="99"

#####################################
#   Used to generate a STAR index   #
#   for mixed species experiments   #
#                                   #
#   author: ccc2177@columbia.edu    #
#####################################

# You want to run this on a very large AWS instance
# The simplest way is to start an inatsnce of STAR with --no-terminate and specify a large volsize
# STAR: https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf

############### Retrieving data
# Gets the primary assembly and gtf from Ensembl - NOT UCSC YOU NEED FULL GENE MODELS IN THE GTF FILES
curl -L -C - ftp://ftp.ensembl.org/pub/release-${ensembl_ver}/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz -o hg.fa.gz
curl -L -C - ftp://ftp.ensembl.org/pub/release-${ensembl_ver}/fasta/mus_musculus/dna/Mus_musculus.GRCm38.dna.primary_assembly.fa.gz -o mm.fa.gz
curl -L -C - ftp://ftp.ensembl.org/pub/release-${ensembl_ver}/gtf/homo_sapiens/Homo_sapiens.GRCh38.${ensembl_ver}.gtf.gz -o hg.gtf.gz
curl -L -C - ftp://ftp.ensembl.org/pub/release-${ensembl_ver}/gtf/mus_musculus/Mus_musculus.GRCm38.${ensembl_ver}.gtf.gz -o mm.gtf.gz

mkdir -p backup
cp *.gz backup

# Uncompress, required by STAR
gunzip -f *.gz

############# Prefixing
# GTF: skip comments, add prefix at each line
awk -v org="HUMAN" '!/^#!/ {$0=org"_"$0; print}' hg.gtf > hg_prefixed.gtf
awk -v org="MOUSE" '!/^#!/ {$0=org"_"$0; print}' mm.gtf > mm_prefixed.gtf

# Fasta: no comments, but only fasta headers must be achanged
awk -v org="HUMAN" '/^>/{sub(/^>/, ">"org"_"); print;next;}{print}' hg.fa > hg_prefixed.fa
awk -v org="MOUSE" '/^>/{sub(/^>/, ">"org"_"); print;next;}{print}' mm.fa > mm_prefixed.fa

# Concatenating
cat hg_prefixed.gtf mm_prefixed.gtf > mixed.gtf
cat hg_prefixed.fa mm_prefixed.fa > mixed.fa

exit 0

############## STAR
# Output
mkdir -p $OUT

# STAR
STAR --runThreadN 31 --runMode genomeGenerate --genomeDir $OUT --genomeFastaFiles mixed.fa --sjdbGTFfile mixed.gtf
cp Log.out $OUT
aws s3 cp $OUT s3://dplab-data/genomes/
