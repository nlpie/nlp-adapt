temp=$(mktemp "${TMPDIR:-/tmp/}$(basename $0).XXXX")

{
    grep -P -nl -- '\d+/\d+-' "$@"
    grep -nl '[^[:print:]]' "$@"
    grep -P -nl '[^\x00-\x7F]' "$@"
    grep -nl $'\t' "$@"
    pcregrep -Mnl  '^$.*\n^\.' "$@"
} >> "$temp"

mkdir -p $DATA_DIRECTORY/quarantine

while read -r filename
do
    mv -- "$filename" $DATA_DIRECTORY/quarantine
done < "$temp"
