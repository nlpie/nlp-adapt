echo "Preprocess data for annotator consumption"

echo ""
echo "Looking for files with ill-formed fractions:"
grep --color='auto' -P -n -- '\d+/\d+-' $DATA_IN/* || echo "no matches found for ill-formed fractions!"

echo ""
echo "Looking for files with non-printable ASCII characters:"
grep --color='auto' -n '[^[:print:]]' $DATA_IN/* || echo "no matches found for non-printable ASCII characters!"

echo ""
echo "Looking for files with non-printable ASCII characters:"
grep --color='auto' -P -n '[^\x00-\x7F]' $DATA_IN/* || echo "no matches found for non-ASCII characters!"


echo ""
echo "Looking for files with unicode tabs:"
grep --color='auto' -n $'\t' $DATA_IN/* || echo "no matches found for unicode tabs!"


echo ""
echo "Looking for files with floating periods:"
pcregrep --color='auto' -Mn  '^$.*\n^\.' $DATA_IN/* || echo "no matches found for floating periods!"






