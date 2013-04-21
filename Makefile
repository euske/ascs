# Makefile

ZIP=zip
RM=rm -f
CP=cp -f
MKDIR=mkdir -p
RSYNC=rsync -av
JAVA=java

FLEX_HOME=../flex_sdk4
AS3COMPILE=$(JAVA) -jar $(FLEX_HOME)/lib/mxmlc.jar +flexlib=$(FLEX_HOME)/frameworks -static-rsls

TARGET=main.swf
LIVE_URL=live.tabesugi.net:public/cgi/root/host/live.tabesugi.net/live.swf

all: $(TARGET)

clean:
	-$(RM) $(TARGET)

update: $(TARGET)
	$(SSHON)
	$(RSYNC) $(TARGET) $(LIVE_URL)

$(TARGET): ./src/*.as
	$(AS3COMPILE) -compiler.source-path=$(SRCDIR) -o $@ ./src/Main.as
