#!/bin/bash
# Check length of lines in training text. Long lines wrap and create multi-line tifs.
# $1 - TESSTRAIN_LANG
# $2 - TESSTRAIN_SCRIPT
# $3 - START_MODEL
# $4 - MODEL_NAME
# $5 - Training Type - FineTune, ReplaceLayer or blank (from scratch)
# $6 - TESSTRAIN_FONT
##
# FineTune - TESSTRAIN_MAX_LINES=1000 EPOCHS=10 
# ReplaceLayer - TESSTRAIN_MAX_LINES=10000 EPOCHS=100
# Scratch - TESSTRAIN_MAX_LINES=50000 EPOCHS=100
# eg. nohup bash -x font2model-ben.sh ben Bengali ben BenKalpurush ReplaceLayer '"Kalpurush"' > Kalpurush.log &
##
## This format for specifying fontname from command line

shuf -o data/$4.training_text < data/$4.training_text

make -f Makefile-font2model \
MODEL_NAME=$4 \
clean-groundtruth \
clean-output \
clean-log

make -f Makefile-font2model \
TESSDATA=$HOME/tessdata_best \
TESSTRAIN_FONTS_DIR=/usr/share/fonts \
TESSTRAIN_TEXT=data/$4.training_text \
TESSTRAIN_MAX_LINES=10000 EPOCHS=100 \
TESSTRAIN_LANG=$1 \
TESSTRAIN_SCRIPT=$2 \
START_MODEL=$3 \
MODEL_NAME=$4 \
TRAIN_TYPE=$5 \
TESSTRAIN_FONT="$6" \
DEBUG_INTERVAL=-1 \
training  --trace
