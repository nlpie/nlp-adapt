rm /home/ubuntu/amicus/TypeSystems/*
cp /home/ubuntu/amicus/nlpie/AmicusTypeSystem.xml /home/ubuntu/amicus/TypeSystems/AmicusTypeSystem.xml
cp /home/ubuntu/host_data/biomedicus_out/TypeSystem.xml /home/ubuntu/amicus/TypeSystems/BiomedICUSTypeSystem.xml
cp /home/ubuntu/host_data/ctakes_out/TypeSystem.xml /home/ubuntu/amicus/TypeSystems/cTAKESTypeSystem.xml
cp /home/ubuntu/host_data/metamap_out/TypeSystem.xml /home/ubuntu/amicus/TypeSystems/MetaMapTypeSystem.xml
pushd $AMICUS_HOME
./build.sh
popd

java -jar /home/ubuntu/amicus/amicus.jar /home/ubuntu/amicus/nlpie/merge_concepts.yml

pushd $AMICUS_OUT
zip -r $AMICUS_OUT .
popd

AMICUS_META='{"systemName":"Amicus", "systemDescription":"Amicus merged annotations", "instance":"default"}'

RESPONSE=$(echo $AMICUS_META | curl -sS -d @- http://localhost:9200/_nlptab-systemindexmeta)
curl -sS --data-binary @$AMICUS_OUT.zip -H 'Content-Type: application/zip' "http://localhost:9200/_nlptab-systemindex?instance=default&index=$(echo $RESPONSE | jq -r .index)&useXCas=false"
