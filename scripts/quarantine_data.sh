temp=$(mktemp "${TMPDIR:-/tmp/}$(basename $0).XXXX")

{
                                         # Offenders:                                     # Mitigation:
    ggrep -P -lr -- '\d+/\d+-' "$@"      # e.g. "45/53-"                                  # replace "-" with " "
    ggrep -P -lr -- '\.+\S/\S\s+' "$@"   # e.g. ".H/O "                                   # replace "." with " "
    ggrep -lr -- '[^[:print:]]' "$@"     # i.e. control codes                             # delete matched characters
    ggrep -P -lr -- '[^\x00-\x7F]' "$@"  # i.e. unicode                                   # replace characters with closest ascii
    ggrep -lr -- $'\t' "$@"              # i.e. tabs                                      # replace tab with " "
    pcregrep -Mlr -- '^$.*\n^\.' "$@"    # e.g. "\n. "                                    # replace "." with " "
    ggrep -P -lr -- '\s+\.+\s+' "$@"     # e.g. " . "                                     # replace "." with " "
    ggrep -P -lr -- '^\.+' "$@"          # i.e. period alone at the beginning of a line   # replace "." with " "
    # TODO                               # i.e. pipes                                     # replace "|" with " "
} >> "$temp"

mkdir -p quarantine

while read -r filename
do
    [ -f "$filename" ] && mv -- "$filename" quarantine
done < "$temp"

# Usage:
#       ./quarantine_data.sh <directories to quarantine>
# Example:
#       ./quarantine_data.sh data_in
