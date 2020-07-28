version 1.0

task RunSTAR {

    input {
        File fasta
        File gtf
        Int sjdbOverhang = 101
    }

    Int numThreads = 32
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
        docker: "hisplan/cromwell-star:2.5.3a"
        # disks: "local-disk " + ceil(10 * (if inputSize < 1 then 5 else inputSize)) + " HDD"
        cpu: numThreads
        memory: "128 GB"
    }
}
