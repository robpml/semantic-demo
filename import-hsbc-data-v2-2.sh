#!/bin/sh
export MLCP=/Users/bdang/softwares/mlcp/mlcp-8.0.6.3/bin/mlcp.sh
PORT=8999
USER=admin
PASSWORD=admin
INPUT_FILE_TYPE=delimited_text
DATABASE=hsbc
Echo  "** importing Data **"
Echo
for file in data/*.csv
do
    filename=$(basename "$file")
    extension="${filename##*.}"
    filename="${filename%.*}"
    SINGULAR=${filename%?}
    PLURAL=$filename
    $MLCP import -host localhost -port $PORT -username $USER -password $PASSWORD -mode local -input_file_path data/$PLURAL.csv -input_file_type $INPUT_FILE_TYPE -delimited_root_name $SINGULAR -generate_uri -output_uri_prefix /$PLURAL -output_uri_replace "Users/bdang/projects/HSBC/project/data/,'',.csv,''" -output_uri_suffix .xml -output_collections /$PLURAL,sourceData
done