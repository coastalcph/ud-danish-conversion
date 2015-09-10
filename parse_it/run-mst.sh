nohup sh parse-mst.sh ../treebanks/UD_Danish/da-ud-train.conllu ../treebanks/UD_Danish/da-ud-test.conllu ../treebanks/UD_Danish/da-ud-dev.conllu UD_Danish > nohup.mst.out 2> nohup.mst.err & 

nohup sh parse-mst.sh ../data/conll-x/danish_ddt_train.conll ../data/conll-x/danish_ddt_test.conll ../data/conll-x/danish_ddt_dev.conll conll-x > nohup.mst.conll.out 2> nohup.mst.conll.err & 
