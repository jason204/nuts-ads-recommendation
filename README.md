# Distributed Real Time Recommendation System Using Spark

## Requirements
- Scala 2.11.8
- JDK 1.7.0_79
- Spark 2.0.0
- Maven 3.3.9

## Build
To build this project, execute the following command:

    bin/build.sh
### Params of bin/build.sh
```
Usage:
-h                    print help message.
module_name           compile module named module_name, modules available: random-forest
```

## Run
To run this project, execute the following command:

    bin/run.sh jar-file-in-the-jars-directory class-name [params]
### Params of bin/run.sh
```
Usage: ./bin/run.sh the-file-you-want-to-submit.jar classname [param1 param2 param3 ...]
Available commands:

========== Feature extractor ==========

HexFileTokenCounterFeatureExtractor:
  $ bin/run.sh malware-classification-random-forest-1.0.0-jar-with-dependencies.jar com.huntdreams.rf.feature.extract.HexFileTokenCounterFeatureExtractor masterUrl dataPath trainDataPath trainLabels
  $ bin/run.sh malware-classification-random-forest-1.0.0-jar-with-dependencies.jar com.huntdreams.rf.feature.extract.HexFileTokenCounterFeatureExtractor dataPath trainDataPath trainLabels

==========  Classification   ==========

HexFileTokenCountFeatureRFClassifier:
  $ bin/run.sh malware-classification-random-forest-1.0.0-jar-with-dependencies.jar com.huntdreams.rf.classification.HexFileTokenCountFeatureRFClassifier masterUrl hexFileTokenCountFeature 500 StringIndexer
  $ bin/run.sh malware-classification-random-forest-1.0.0-jar-with-dependencies.jar com.huntdreams.rf.classification.HexFileTokenCountFeatureRFClassifier hexFileTokenCountFeature 500 StringIndexer
```

## Evaluation

## Code Directory