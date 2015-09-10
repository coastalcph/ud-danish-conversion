echo "UD_Danish"
echo "da dev"
./eval07.pl -q -g ../treebanks/UD_Danish/da-ud-dev.conllu -s parsed/mate/UD_Danish/da-ud-dev.conllu09.parsed.conll07
echo "da test"
./eval07.pl -q -g ../treebanks/UD_Danish/da-ud-test.conllu -s parsed/mate/UD_Danish/da-ud-test.conllu09.parsed.conll07

echo "+++++++++"
echo "conll-x (CDT)"
echo "da dev"
./eval07.pl -q -g ../data/conll-x/danish_ddt_dev.conll -s parsed/mate/conll-x/danish_ddt_dev.conll09.conll07
echo "da test"
./eval07.pl -q -g ../data/conll-x/danish_ddt_test.conll -s parsed/mate/conll-x/danish_ddt_test.conll09.conll07

