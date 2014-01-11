# Makefile

DEL=del /f
COPY=copy /y
JAVA=java
START=start "test" /B
FLEX_HOME=..\flex_sdk4

MXMLC=$(JAVA) -jar $(FLEX_HOME)\lib\mxmlc.jar +flexlib=$(FLEX_HOME)\frameworks
FDB=$(JAVA) -jar $(FLEX_HOME)\lib\fdb.jar

# Project settings
CFLAGS=-static-rsls
CFLAGS_DEBUG=-debug=true
TARGET=main.swf
TARGET_DEBUG=main_d.swf

all: $(TARGET)

clean:
	-$(DEL) $(TARGET) $(TARGET_DEBUG)

run: $(TARGET)
	$(START) $(TARGET)

debug: $(TARGET_DEBUG)
	$(FDB) $(TARGET_DEBUG)

$(TARGET): .\src\*.as .\assets\*.*
	$(MXMLC) $(CFLAGS) -compiler.source-path=.\src\ -o $@ .\src\Main.as

$(TARGET_DEBUG): .\src\*.as .\assets\*.*
	$(MXMLC) $(CFLAGS) $(CFLAGS_DEBUG) -compiler.source-path=.\src\ -o $@ .\src\Main.as
