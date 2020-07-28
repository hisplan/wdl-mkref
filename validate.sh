#!/usr/bin/env bash

java -jar ~/Applications/womtool.jar \
    validate \
    mkref.wdl \
    --inputs ./configs/mkref.inputs.json
