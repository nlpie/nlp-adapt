# MetaMap UIMA settings
# source this in bash or sh using:
#   . ./bin/setup_uima.sh
BASEDIR=/home/ubuntu/metamap
export BASEDIR

MM_API_UIMA=${BASEDIR}/src/uima
export MM_API_UIMA
JAVAAPI=${BASEDIR}/src/javaapi/dist/MetaMapApi.jar
export JAVAAPI
PROLOGBEANS=${BASEDIR}/src/javaapi/dist/prologbeans.jar
export PROLOGBEANS

# Apache UIMA classes
UIMA_HOME=/home/ubuntu/uima
export UIMA_HOME
UIMA_CLASSPATH=\
${UIMA_HOME}/examples/resources:\
${UIMA_HOME}/lib/uima-core.jar:\
${UIMA_HOME}/lib/uima-document-annotation.jar:\
${UIMA_HOME}/lib/uima-cpe.jar:\
${UIMA_HOME}/lib/uima-tools.jar:\
${UIMA_HOME}/lib/uima-examples.jar:\
${UIMA_HOME}/lib/uima-adapter-soap.jar:\
${UIMA_HOME}/lib/uima-adapter-vinci.jar:\
${UIMA_HOME}/lib/jVinci.jar  
export UIMA_CLASSPATH

# classpath
CLASSPATH=\
${CLASSPATH}:\
${MM_API_UIMA}/classes:\
${MM_API_UIMA}/desc:\
${BASEDIR}/nlpie:\
${MM_API_UIMA}/lib/metamap-api-uima.jar:\
${UIMA_CLASSPATH}:\
${JAVAAPI}:\
${PROLOGBEANS}
export CLASSPATH

PATH=$PATH:${UIMA_HOME}/bin
export PATH

#fin
