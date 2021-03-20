CC = gcc

SRC = src
BUILD = build
PROGRAM = main
CFLAGS= -Wall -g

INC = -Iinclude -Ilib/clog/include -Ilib/rpi-sense-hat-api/include
LIB = -lm -L ./lib -l:clog/lib/clog.a -l:rpi-sense-hat-api/lib/sense-api.a


FILES = $(wildcard $(SRC)/*.c)

# directories with makefiles which must be called
SUBMAKE = lib/clog lib/rpi-sense-hat-api


all: debug run

makeLibs:
	for dir in $(SUBMAKE); do \
		$(MAKE) -C $$dir ; \
	done

testLibs: 
	for dir in $(SUBMAKE); do \
		$(MAKE) -C $$dir test; \
	done

cleanLibs:
	for dir in $(SUBMAKE); do \
		$(MAKE) -C $$dir clean; \
	done

debug: makeLibs
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) $(FILES) $(LIB) $(INC) -o $(BUILD)/$(PROGRAM)

run:
	./$(BUILD)/$(PROGRAM)

clean: cleanLibs
	rm -rf $(BUILD)/*