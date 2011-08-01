include $(GNUSTEP_MAKEFILES)/common.make

#
# Application
#
VERSION = 0.1
TOOL_NAME = etbuild

${TOOL_NAME}_LANGUAGES = English

${TOOL_NAME}_OBJC_FILES = \
	BKTask.m\
	main.m

${TOOL_NAME}_OBJCFLAGS = -std=c99 -g -fobjc-nonfragile-abi
${TOOL_NAME}_LDFLAGS += -g 
CC=clang

include $(GNUSTEP_MAKEFILES)/aggregate.make
include $(GNUSTEP_MAKEFILES)/tool.make
