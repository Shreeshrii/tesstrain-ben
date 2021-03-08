# tesstrain-ben

Training workflow for Tesseract 5 as a Makefile.

## Install

### leptonica, tesseract

You will need latest version of tesseract built with the
training tools and matching leptonica bindings.

### Python

You need a recent version of Python 3.x. For image processing the Python library `Pillow` is used.
If you don't have a global installation, please use the provided requirements file `pip install -r requirements.txt`.

## Training

### To train from training_text and fonts

- `Makefile-font2model` can be used to train from training_text and fonts.
- `font2model-ben.sh` shows how to invoke it for training `Bengali` for `Kalpurush` font with `ben` as the START_MODEL.
- `plot.sh` can be invoked with the MODEL_NAME, evaluation list and max CER to be displayed.

### Training for Kalpurush font

The repo also has the results of the training run using `data/BenKalpurush.training_text` as input with Kalpurush font.

- `data/ben/BenKalpurush.lstm` is the lstm file from the START_MODEL.
- `data/BenKalpurush/BenKalpurush.unicharset` is the unicharset from the training_text.
- `data/BenKalpurush/BenKalpurush.traineddata` is the starter traineddata for training. This is the PROTO_MODEL and cannot be used for recognition.
- `data/BenKalpurush/all-lstmf` has a list of all lstmf files generated from the training_text and font.
- `data/BenKalpurush/list.train` has the list of the training subset of all lstmf files.
- `data/BenKalpurush/list.eval` has the list of the evaluation subset of all lstmf files.

- `data/BenKalpurush/checkpoints` has the main training checkpoint file.
- `data/BenKalpurush/tessdata_best` has the `float/best` traineddata generated from the final checkpoint.
- `data/BenKalpurush/tessdata_fast` has the `integer/fast` traineddata generated from the final checkpoint.
- `data/BenKalpurush.traineddata` is a copy of the final `float/best` traineddata. This can be used for recognition.

- `data/BenKalpurush/plot/BenKalpurush-eval-cer.png` graphs the training run.

To do the rerun complete training, give the following command.
```
nohup bash -x font2model-ben.sh ben Bengali ben BenKalpurush ReplaceLayer '"Kalpurush"' > Kalpurush.log &
```

To plot the training progress, give the following command.

```
bash -x plot.sh BenKalpurush eval 10
```

### To train from images and ground truth (see tesstrain repo for more details)

Place ground truth consisting of line images and transcriptions in the folder
`data/MODEL_NAME-ground-truth`. This list of files will be split into training and
evaluation data, the ratio is defined by the `RATIO_TRAIN` variable.

Images must be TIFF and have the extension `.tif` or PNG and have the
extension `.png`, `.bin.png` or `.nrm.png`.

Transcriptions must be single-line plain text and have the same name as the
line image but with the image extension replaced by `.gt.txt`.

```
 make training MODEL_NAME=name-of-the-resulting-model
```

## License

Software is provided under the terms of the `Apache 2.0` license.
