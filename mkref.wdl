version 1.0

import "modules/DownloadEnsembl.wdl" as DownloadEnsembl
import "modules/AddPrefix.wdl" as AddPrefix
import "modules/Merge.wdl" as Merge

workflow mkref {

    input {
        String genomeVersion
        String ensemblVersion
    }

    call DownloadEnsembl.DownloadEnsemblHuman {
        input:
            genomeVersion = genomeVersion,
            ensemblVersion = ensemblVersion
    }

    call DownloadEnsembl.DownloadEnsemblMouse {
        input:
            genomeVersion = genomeVersion,
            ensemblVersion = ensemblVersion
    }

    call AddPrefix.AddPrefixGtf as AddPrefixGtfHuman {
        input:
            prefix = "HUMAN",
            gzippedGtf = DownloadEnsemblHuman.outGtf
    }

    call AddPrefix.AddPrefixFasta as AddPrefixFastaHuman {
        input:
            prefix = "HUMAN",
            gzippedFasta = DownloadEnsemblHuman.outFasta
    }

    call AddPrefix.AddPrefixGtf as AddPrefixGtfMouse {
        input:
            prefix = "MOUSE",
            gzippedGtf = DownloadEnsemblMouse.outGtf
    }

    call AddPrefix.AddPrefixFasta as AddPrefixFastaMouse {
        input:
            prefix = "MOUSE",
            gzippedFasta = DownloadEnsemblMouse.outFasta
    }

    call Merge.Merge as MergeGtf {
        input:
            files = [AddPrefixGtfHuman.outPrefixedGtf, AddPrefixGtfMouse.outPrefixedGtf],
            extension = "gtf"
    }

    call Merge.Merge as MergeFasta {
        input:
            files = [AddPrefixFastaHuman.outPrefixedFasta, AddPrefixFastaMouse.outPrefixedFasta],
            extension = "fasta"
    }

    output {
        File outMergedGtf = MergeGtf.outMergedFile
        File outMergedFasta = MergeFasta.outMergedFile
    }
}
