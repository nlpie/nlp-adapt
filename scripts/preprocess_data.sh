echo "Preprocess data for annotator consumption"

echo ""
echo "Looking for files with ill-formed fractions:"
grep -Pn -- '\d+/\d+-' $DATA_IN/* || echo "no matches found for ill-formed fractions!"


echo ""
echo "Looking for files with non-printable ASCII characters:"
grep -n '[^[:print:]]' $DATA_IN/* || echo "no matches foundfor non-printable ASCII characters!"


echo ""
echo "Looking for files with unicode tabs:"
grep -n $'\t' $DATA_IN/* || echo "no matches found for unicode tabs!"


echo ""
echo "Looking for files with floating periods:"
pcregrep -Mn  '^$.*\n^\.' $DATA_IN/* || echo "no matches found for floating periods!"





