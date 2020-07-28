version 1.0

import "modules/DownloadEnsembl.wdl" as DownloadEnsembl

workflow DownloadEnsembl {

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

    output {
        File outHumanFasta = DownloadEnsemblHuman.outFasta
        File outHumanGtf = DownloadEnsemblHuman.outGtf
        File outMouseFasta = DownloadEnsemblMouse.outFasta
        File outMouseGtf = DownloadEnsemblMouse.outGtf        
    }
}