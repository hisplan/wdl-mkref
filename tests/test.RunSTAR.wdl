version 1.0

import "modules/RunSTAR.wdl" as RunSTAR

workflow RunSTAR {

    input {
        File fasta
        File gtf
        Int sjdbOverhang
    }

    call RunSTAR.RunSTAR {
        input:
            fasta = fasta,
            gtf = gtf,
            sjdbOverhang = sjdbOverhang
    }

    output {
        Array[File] outs = RunSTAR.outs
    }
}