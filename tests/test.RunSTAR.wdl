version 1.0

import "modules/RunSTAR.wdl" as RunSTAR

workflow RunSTAR {

    input {
        File fasta
        File gtf
        Int sjdbOverhang
        String starVersion

        # docker-related
        String dockerRegistry
    }

    call RunSTAR.RunSTAR {
        input:
            fasta = fasta,
            gtf = gtf,
            sjdbOverhang = sjdbOverhang,
            starVersion = starVersion,
            dockerRegistry = dockerRegistry
    }

    output {
        Array[File] outs = RunSTAR.outs
    }
}