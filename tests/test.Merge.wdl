version 1.0

import "modules/Merge.wdl" as Merge

workflow Merge {

    input {
        Array[File] files
        String extension
    }

    call Merge.Merge {
        input:
            files = files,
            extension = extension
    }

    output {
        File outMergedFile = Merge.outMergedFile
    }
}