PARSER=mst
echo "PARSER $PARSER"
echo "UD_Danish"
echo "da dev"
./eval07.pl -q -g ../treebanks/UD_Danish/da-ud-dev.conllu -s parsed/$PARSER/UD_Danish/da-ud-dev.conllu.out
echo "da test"
./eval07.pl -q -g ../treebanks/UD_Danish/da-ud-test.conllu -s parsed/$PARSER/UD_Danish/da-ud-test.conllu.out

echo "+++++++++"
echo "conll-x (CDT)"
echo "da dev"
./eval07.pl -q -g ../data/conll-x/danish_ddt_dev.conll -s parsed/$PARSER/conll-x/danish_ddt_dev.conll.out
echo "da test"
./eval07.pl -q -g ../data/conll-x/danish_ddt_test.conll -s parsed/$PARSER/conll-x/danish_ddt_test.conll.out

