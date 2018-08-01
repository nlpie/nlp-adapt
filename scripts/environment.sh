#!/bin/bash

#General Config
export SHARE_NAME=data
export DATA_DIRECTORY=/home/ubuntu/host_data
export DATA_IN=$DATA_DIRECTORY/data_in
export RANDOM_SAMPLE=50
export SAMPLE_FILE=$DATA_DIRECTORY/nlptab_manifest.txt

#UIMA
export UIMA_HOME=/home/ubuntu/uima

#CLAMP
export CLAMP_HOME=/home/ubuntu/clamp
export CLAMP_OUT=$DATA_DIRECTORY/clamp_out

#cTAKES
export CTAKES_HOME=/home/ubuntu/ctakes
# source /home/ubuntu/umls.sh
export CTAKES_OUT=$DATA_DIRECTORY/ctakes_out

#METAMAP
export METAMAP_HOME=/home/ubuntu/metamap
export PATH=/home/ubuntu/metamap/bin:$PATH
export METAMAP_OUT=$DATA_DIRECTORY/metamap_out

#BIOMEDICUS
export BIOMEDICUS_HOME=/home/ubuntu/biomedicus
export BIOMEDICUS_CONF=/home/ubuntu/biomedicus/config
export BIOMEDICUS_OUT=$DATA_DIRECTORY/biomedicus_out

#AMICUS
export AMICUS_HOME=/home/ubuntu/amicus
export AMICUS_OUT=$DATA_DIRECTORY/amicus_out
