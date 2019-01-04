temp=$(mktemp "${TMPDIR:-/tmp/}$(basename $0).XXXX")

{
    ggrep -P -lr -- '\d+/\d+-' "$@"      # e.g. "45/53-"
    ggrep -P -lr -- '\.+\S/\S\s+' "$@"   # e.g. ".H/O "
    ggrep -lr -- '[^[:print:]]' "$@"     # i.e. control codes
    ggrep -P -lr -- '[^\x00-\x7F]' "$@"  # i.e. unicode
    ggrep -lr -- $'\t' "$@"              # i.e. tabs
    pcregrep -Mlr -- '^$.*\n^\.' "$@"    # e.g. "\n. "
    ggrep -P -lr -- '\s+\.+\s+' "$@"     # e.g. " . "
} >> "$temp"

mkdir -p quarantine

while read -r filename
do
    mv -- "$filename" quarantine
done < "$temp"

# Usage:
#       ./quarantine_data.sh <directories to quarantine>
# Example:
#       ./quarantine_data.sh data_in
