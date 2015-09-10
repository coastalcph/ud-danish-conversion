echo "da dev"
./eval07.pl -q -g ../treebanks/UD_Danish/da-ud-dev.conllu -s parsed/mate/da-ud-dev.conllu09.parsed.conll07
echo "da test"
./eval07.pl -q -g ../treebanks/UD_Danish/da-ud-test.conllu -s parsed/mate/da-ud-test.conllu09.parsed.conll07
