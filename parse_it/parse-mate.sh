
#### UD_Danish ### 
OUT=parsed/mate/UD_Danish
if [ ! -f $OUT/da-ud-dev.conllu09.parsed.conll07 ]; then
    python ~/lowlands/tools/myconllutils/conll06to09.py ../treebanks/UD_Danish/da-ud-train.conllu > da-ud-train.conllu09
    python ~/lowlands/tools/myconllutils/conll06to09.py ../treebanks/UD_Danish/da-ud-dev.conllu > da-ud-dev.conllu09
    python ~/lowlands/tools/myconllutils/conll06to09.py ../treebanks/UD_Danish/da-ud-test.conllu > da-ud-test.conllu09

    mkdir -p $OUT
    java -cp mate3.6/mate-tools/dist/anna-3.6.jar is2.parser.Parser -model da.model -train da-ud-train.conllu09 -test da-ud-dev.conllu09 -out $OUT/da-ud-dev.conllu09.parsed
    java -cp mate3.6/mate-tools/dist/anna-3.6.jar is2.parser.Parser -model da.model -test da-ud-test.conllu09 -out $OUT/da-ud-test.conllu09.parsed
    
    rm da-ud-train.conllu09 da-ud-dev.conllu09 da-ud-test.conllu09
    
    sh conll09to07pred.sh $OUT/da-ud-dev.conllu09.parsed > $OUT/da-ud-dev.conllu09.parsed.conll07
    sh conll09to07pred.sh $OUT/da-ud-test.conllu09.parsed > $OUT/da-ud-test.conllu09.parsed.conll07
fi
#### conll-x ### 
OUT=parsed/mate/preprocess
if [ ! -f $OUT/da-ud-dev.conllu09.parsed.conll07 ]; then
    python ~/lowlands/tools/myconllutils/conll06to09.py  ../data/steps/preprocess/danish_ddt_train.conll > danish_ddt_train.conll09
    python ~/lowlands/tools/myconllutils/conll06to09.py ../data/steps/preprocess/danish_ddt_test.conll > danish_ddt_test.conll09
    python ~/lowlands/tools/myconllutils/conll06to09.py ../data/steps/preprocess/danish_ddt_dev.conll > danish_ddt_dev.conll09

    mkdir -p $OUT
    java -cp mate3.6/mate-tools/dist/anna-3.6.jar is2.parser.Parser -model da-conllx.model -train danish_ddt_train.conll09 -test danish_ddt_dev.conll09 -out $OUT/danish_ddt_dev.conll09.parsed
    java -cp mate3.6/mate-tools/dist/anna-3.6.jar is2.parser.Parser -model da-conllx.model -test danish_ddt_test.conll09 -out $OUT/danish_ddt_test.conll09
   java -cp mate3.6/mate-tools/dist/anna-3.6.jar is2.parser.Parser -model da-conllx.model -test danish_ddt_dev.conll09 -out $OUT/danish_ddt_dev.conll09
    
    rm danish_ddt_train.conll09 danish_ddt_test.conll09 danish_ddt_dev.conll09

    sh conll09to07pred.sh $OUT/danish_ddt_test.conll09 > $OUT/danish_ddt_test.conll09.conll07
    sh conll09to07pred.sh $OUT/danish_ddt_dev.conll09 > $OUT/danish_ddt_dev.conll09.conll07
fi