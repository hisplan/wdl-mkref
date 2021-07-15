#!/usr/bin/env bash

java -jar ~/Applications/womtool.jar \
    validate \
    mkref.wdl \
    --inputs ./configs/mkref-GRCh38-GRCm38-Ensembl100.inputs.json
