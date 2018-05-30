#!/bin/bash

set -x

umlsUser=$ctakes_umlsuser
umlsPass=$ctakes_umlspw

input=$DATA_IN
output=$CLAMP_OUT

clampbin="$CLAMP_HOME/bin/clamp-nlp-1.4.0-jar-with-dependencies.jar"
pipeline="$CLAMP_HOME/pipeline/clamp-ner-attribute.pipeline.jar"
umlsIndex="$CLAMP_HOME/resource/umls_index/"

java -DCLAMPLicenceFile="$CLAMP_HOME/CLAMP.LICENSE" -Xmx3g -cp $clampbin edu.uth.clamp.nlp.main.PipelineMain \
    -i $input \
    -o $output \
    -p $pipeline \
    -U $umlsUser \
    -P $umlsPass \
    -I $umlsIndex

set +x


