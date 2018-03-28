#!/bin/sh

cd data
mkdir glove

GLOVE_BIN="../glove/build"
for topicwords in topic-*words; do
    echo "Processing $topicwords"
    $GLOVE_BIN/vocab_count -min-count 5 -verbose 2 < "$topicwords" > glove/${topicwords}-vocab.txt
    
    $GLOVE_BIN/cooccur -memory 4.0 -vocab-file glove/"$topicwords"-vocab.txt -verbose 2 -window-size 15 < "$topicwords" > glove/"$topicwords"-cooccurrence.bin
    
    $GLOVE_BIN/shuffle -memory 4.0 -verbose 2 < glove/"$topicwords"-cooccurrence.bin > glove/"$topicwords"-cooccurrence.shuf.bin
    
    $GLOVE_BIN/glove -save-file glove/"$topicwords"-vectors -threads 8 -input-file glove/"$topicwords"-cooccurrence.shuf.bin -x-max 10 -iter 15 -vector-size 200 -binary 2 -vocab-file glove/"$topicwords"-vocab.txt -verbose 2
    
done
