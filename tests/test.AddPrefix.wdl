version 1.0

import "modules/AddPrefix.wdl" as AddPrefix

workflow AddPrefix {

    input {
        File humanGtf
        File mouseGtf
        File humanFasta
        File mouseFasta
    }

    call AddPrefix.AddPrefixGtf as AddPrefixGtfHuman {
        input:
            prefix = "HUMAN",
            gzippedGtf = humanGtf
    }

    call AddPrefix.AddPrefixFasta as AddPrefixFastaHuman {
        input:
            prefix = "HUMAN",
            gzippedFasta = humanFasta
    }


    # call AddPrefix.AddPrefixGtf as AddPrefixGtfMouse {
    #     input:
    #         prefix = "MOUSE",
    #         gzippedGtf = mouseGtf
    # }

    # call AddPrefix.AddPrefixFasta as AddPrefixFastaMouse {
    #     input:
    #         prefix = "MOUSE",
    #         gzippedFasta = mouseFasta
    # }

    output {
        File outHumanGtf = AddPrefixGtfHuman.outPrefixedGtf
        File outHumanFasta = AddPrefixFastaHuman.outPrefixedFasta
        # File outMouseGtf = AddPrefixGtfMouse.outPrefixedGtf
        # File outMouseFasta = AddPrefixFastaMouse.outPrefixedFasta
    }
}