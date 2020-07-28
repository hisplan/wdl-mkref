version 1.0

task FilterBiotypes {

    input {
        Array[String] biotypes
        File gtf
    }

    Float inputSize = size(gtf, "GiB")

    command <<<
        set -euo pipefail

        python3 /opt/filter_biotypes.py \
            --in ~{gtf} \
            --out annotations.gtf \
            --biotypes ~{sep=" " biotypes}
    >>>

    output {
        File outGtf = "annotations.gtf"
    }

    runtime {
        docker: "hisplan/gtf-utils:0.0.1"
        # disks: "local-disk " + ceil(10 * (if inputSize < 1 then 5 else inputSize)) + " HDD"
        cpu: 4
        memory: "64 GB"
    }
}
