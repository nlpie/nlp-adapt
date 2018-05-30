##### Run CLAMP #####
source /home/ubuntu/umls.sh
mkdir -p $CLAMP_OUT
$CLAMP_HOME/nlpie/run_nlpie_pipeline.sh

##### Create Archive for NLP-TAB #####
rm $CLAMP_OUT/*.txt
pushd $CLAMP_OUT
for f in *.xmi; do mv -- "$f" "${f%.xmi}.txt.xmi"; done

cp $CLAMP_HOME/nlpie/TypeSystem.xml $CLAMP_OUT/TypeSystem.xml
if [ ! -f $SAMPLE_FILE ]; then
    ls $DATA_IN | shuf -n $RANDOM_SAMPLE | sed 's/\.txt/\.txt\.xmi/' > $SAMPLE_FILE
    echo "TypeSystem.xml" >> $SAMPLE_FILE
fi

zip $CLAMP_OUT -@ < $SAMPLE_FILE
popd

##### Create CLAMP NLP-TAB profile and upload archive #####
CLAMP_META='{"systemName":"CLAMP", "systemDescription":"CLAMP annotation engine", "instance":"default"}'
RESPONSE=$(echo $CLAMP_META | curl -sS -d @- http://localhost:9200/_nlptab-systemindexmeta)
curl -sS --data-binary @$CLAMP_OUT.zip -H 'Content-Type: application/zip' "http://localhost:9200/_nlptab-systemindex?instance=default&index=$(echo $RESPONSE | jq -r .index)&useXCas=false"
