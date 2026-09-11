TARGET = crystalkv
SRC = src/main.cr
SRCS = $(shell find src -name '*.cr')
BUILD_OPTS = --release --link-flags="-s -Wl,--gc-sections"

all: $(TARGET)

$(TARGET): $(SRCS) shard.yml
	crystal build $(SRC) $(BUILD_OPTS) -o $(TARGET)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: all run clean