##### Run BiomedICUS #####
$BIOMEDICUS_HOME/bin/runCPE.sh $BIOMEDICUS_HOME/nlpie/PlainTextCPM_nlpie.xml

##### Create Archive for NLP-TAB #####
if [ ! -f $SAMPLE_FILE ]; then
    ls $DATA_IN | shuf -n $RANDOM_SAMPLE | sed 's/\.txt/\.txt\.xmi/' > $SAMPLE_FILE
    echo "TypeSystem.xml" >> $SAMPLE_FILE
fi
pushd $BIOMEDICUS_OUT
zip $BIOMEDICUS_OUT -@ < $SAMPLE_FILE
popd

##### Create BiomedICUS NLP-TAB profile and upload archive #####
BIOMEDICUS_META='{"systemName":"BiomedICUS", "systemDescription":"BiomedICUS annotation engine", "instance":"default"}'
RESPONSE=$(echo $BIOMEDICUS_META | curl -sS -d @- http://localhost:9200/_nlptab-systemindexmeta)
curl -sS --data-binary @$BIOMEDICUS_OUT.zip -H 'Content-Type: application/zip' "http://localhost:9200/_nlptab-systemindex?instance=default&index=$(echo $RESPONSE | jq -r .index)&useXCas=false"

