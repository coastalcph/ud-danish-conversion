python ~/lowlands/tools/myconllutils/conll06to09.py ../treebanks/UD_Danish/da-ud-train.conllu > da-ud-train.conllu09
python ~/lowlands/tools/myconllutils/conll06to09.py ../treebanks/UD_Danish/da-ud-dev.conllu > da-ud-dev.conllu09
python ~/lowlands/tools/myconllutils/conll06to09.py ../treebanks/UD_Danish/da-ud-test.conllu > da-ud-test.conllu09

mkdir -p parsed/mate
java -cp mate3.6/mate-tools/dist/anna-3.6.jar is2.parser.Parser -model da.model -train da-ud-train.conllu09 -test da-ud-dev.conllu09 -out parsed/mate/da-ud-dev.conllu09.parsed
java -cp mate3.6/mate-tools/dist/anna-3.6.jar is2.parser.Parser -model da.model -test da-ud-test.conllu09 -out parsed/mate/da-ud-test.conllu09.parsed

rm da-ud-train.conllu09 da-ud-dev.conllu09 da-ud-test.conllu09

sh conll09to07pred.sh parsed/mate/da-ud-dev.conllu09.parsed > parsed/mate/da-ud-dev.conllu09.parsed.conll07
sh conll09to07pred.sh parsed/mate/da-ud-test.conllu09.parsed > parsed/mate/da-ud-test.conllu09.parsed.conll07