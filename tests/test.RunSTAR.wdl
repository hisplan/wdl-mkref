version 1.0

import "modules/RunSTAR.wdl" as RunSTAR

workflow RunSTAR {

    input {
        File fasta
        File gtf
        Int sjdbOverhang
        String starVersion
    }

    call RunSTAR.RunSTAR {
        input:
            fasta = fasta,
            gtf = gtf,
            sjdbOverhang = sjdbOverhang,
            starVersion = starVersion
    }

    output {
        Array[File] outs = RunSTAR.outs
    }
}