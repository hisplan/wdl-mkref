version 1.0

task AddPrefixGtf {

    input {
        String prefix
        File gzippedGtf
    }

    parameter_meta {
        prefix: "e.g. HUMAN or MOUSE"
    }

    command <<<
        set -euo pipefail

        gtf=`basename ~{gzippedGtf} .gz`
        gunzip -c ~{gzippedGtf} > ${gtf}

        awk -v org="~{prefix}" '!/^#!/ {$0=org"_"$0; print}' ${gtf} > ~{prefix}.gtf
    >>>

    output {
        File outPrefixedGtf = prefix + ".gtf"
    }

    runtime {
        docker: "ubuntu:18.04"
        # disks: "local-disk 100 HDD"
        cpu: 1
        memory: "1 GB"
    }
}

task AddPrefixFasta {

    input {
        String prefix
        File gzippedFasta
    }

    command <<<
        set -euo pipefail

        fasta=`basename ~{gzippedFasta} .gz`
        gunzip -c ~{gzippedFasta} > ${fasta}

        awk -v org="~{prefix}" '/^>/{sub(/^>/, ">"org"_"); print;next;}{print}' ${fasta} > ~{prefix}.fasta
    >>>

    output {
        File outPrefixedFasta = prefix + ".fasta"
    }

    runtime {
        docker: "ubuntu:18.04"
        # disks: "local-disk 100 HDD"
        cpu: 1
        memory: "1 GB"
    }
}
