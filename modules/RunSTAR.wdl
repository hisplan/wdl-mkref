version 1.0

task RunSTAR {

    input {
        File fasta
        File gtf
        Int sjdbOverhang = 101
    }

    Int numThreads = 32

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
        docker: "hisplan/cromwell-star:2.5.3a"
        # disks: "local-disk 100 HDD"
        cpu: numThreads
        memory: "128 GB"
    }
}
