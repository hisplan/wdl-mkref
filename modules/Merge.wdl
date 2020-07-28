version 1.0

task Merge {

    input {
        Array[File] files
        String extension
    }

    parameter_meta {
        extension: "e.g. gtf or fasta"
    }

    command <<<
        set -euo pipefail

        cat ~{sep=" " files} > merged.~{extension}
    >>>

    output {
        File outMergedFile = "merged." + extension
    }

    runtime {
        docker: "ubuntu:18.04"
        # disks: "local-disk 100 HDD"
        cpu: 1
        memory: "1 GB"
    }
}
