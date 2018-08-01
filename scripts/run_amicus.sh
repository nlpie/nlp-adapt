rm /home/ubuntu/amicus/TypeSystems/*
cp /home/ubuntu/amicus/nlpie/AmicusTypeSystem.xml /home/ubuntu/amicus/TypeSystems/AmicusTypeSystem.xml

#BioMedICUS
cp /home/ubuntu/host_data/biomedicus_out/TypeSystem.xml /home/ubuntu/amicus/TypeSystems/BiomedICUSTypeSystem.xml

#cTAKES
cp /home/ubuntu/host_data/ctakes_out/TypeSystem.xml /home/ubuntu/amicus/TypeSystems/cTAKESTypeSystem.xml

#MetaMap
cp /home/ubuntu/host_data/metamap_out/TypeSystem.xml /home/ubuntu/amicus/TypeSystems/MetaMapTypeSystem.xml

# CLAMP
cp /home/ubuntu/host_data/clamp_out/TypeSystem.xml /home/ubuntu/amicus/TypeSystems/TypeSystem.xml

# --- BUILD ---
pushd $AMICUS_HOME
./build.sh
popd

# --- RUN ---
if [ -f /home/ubuntu/Downloads/export.yml ]; then
    java -jar /home/ubuntu/amicus/amicus.jar /home/ubuntu/Downloads/export.yml
else
    java -jar /home/ubuntu/amicus/amicus.jar /home/ubuntu/amicus/nlpie/merge_concepts.yml
fi

##### Create Archive for NLP-TAB #####
if [ ! -f $SAMPLE_FILE ]; then
    ls $DATA_IN | shuf -n $RANDOM_SAMPLE | sed 's/\.txt/\.txt\.xmi/' > $SAMPLE_FILE
    echo "TypeSystem.xml" >> $SAMPLE_FILE
fi
pushd $AMICUS_OUT
zip $AMICUS_OUT -@ < $SAMPLE_FILE
popd

AMICUS_META='{"systemName":"Amicus", "systemDescription":"Amicus merged annotations", "instance":"default"}'

RESPONSE=$(echo $AMICUS_META | curl -sS -d @- http://localhost:9200/_nlptab-systemindexmeta)
curl -sS --data-binary @$AMICUS_OUT.zip -H 'Content-Type: application/zip' "http://localhost:9200/_nlptab-systemindex?instance=default&index=$(echo $RESPONSE | jq -r .index)&useXCas=false"
