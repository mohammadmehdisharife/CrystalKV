TARGET = crystalkv
SRC = src/main.cr
BUILD_OPTS = --release --link-flags="-s -Wl,--gc-sections"

all: build

build:
	crystal build $(SRC) $(BUILD_OPTS) -o $(TARGET)

run: build
	./$(TARGET)

debug:
	crystal build $(SRC) -o $(TARGET)

clean:
	rm -f $(TARGET)
	rm -rf .crystal/

.PHONY: all build run debug clean