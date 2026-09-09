TARGET = crystalkv
SRC = src/main.cr
BUILD_OPTS = --release --link-flags="-s -Wl,--gc-sections"

all: $(TARGET)

$(TARGET): $(SRC)
	crystal build $(SRC) $(BUILD_OPTS) -o $(TARGET)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: all run clean