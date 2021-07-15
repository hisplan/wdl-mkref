version 1.0

task RunSTAR {

    input {
        File fasta
        File gtf
        Int sjdbOverhang = 101
        String starVersion
    }

    # String dockerImage = "hisplan/cromwell-star:2.7.6a"
    # String dockerImage = "hisplan/cromwell-star:2.5.3a"
    String dockerImage = "hisplan/cromwell-star:" + starVersion
    Int numThreads = 15
    Float inputSize = size(fasta, "GiB") + size(gtf, "GiB")

    command <<<
        set -euo pipefail

        mkdir outs

        STAR \
            --runMode genomeGenerate \
            --runThreadN ~{numThreads} \
            --genomeDir outs \
            --genomeFastaFiles ~{fasta} \
            --sjdbGTFfile ~{gtf} \
            --sjdbOverhang ~{sjdbOverhang}
    >>>

    output {
        Array[File] outs = glob("outs/*")
    }

    runtime {
        docker: dockerImage
        # disks: "local-disk " + ceil(10 * (if inputSize < 1 then 5 else inputSize)) + " HDD"
        cpu: numThreads
        memory: "100 GB"
    }
}
