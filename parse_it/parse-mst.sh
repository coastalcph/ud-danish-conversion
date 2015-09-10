#!/bin/bash

#### paths
GB=-Xmx9000m
DECODETYPE=non-proj
MST=mstparser-0.5.1/output/mstparser.jar:mstparser-0.5.1/lib/trove.jar
TRAIN=$1
TEST=$2
DEV=$3
NAME=$4
MODEL=`basename $TRAIN`.model
#### 
java -cp $MST $GB mstparser.DependencyParser train train-file:$TRAIN model-name:$MODEL order:2 decode-type:$DECODETYPE
java -cp $MST $GB mstparser.DependencyParser model-name:$MODEL test test-file:$TEST output-file:$TEST.out order:2 decode-type:$DECODETYPE 
java -cp $MST $GB mstparser.DependencyParser model-name:$MODEL test test-file:$DEV output-file:$DEV.out order:2 decode-type:$DECODETYPE 

mkdir -p parsed/mst/$NAME
mv $TEST.out parsed/mst/$NAME/`basename $TEST`.out
mv $DEV.out parsed/mst/$NAME/`basename $DEV`.out



