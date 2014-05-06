#!/bin/sh
JAVA=java
FLEX_HOME="$HOME/flex_sdk_4.6"
MXMLC="$JAVA -jar $FLEX_HOME/lib/mxmlc.jar +flexlib=$FLEX_HOME/frameworks"

$MXMLC -static-rsls -compiler.source-path=./src/ -o ./bin/main.swf ./src/Main.as
