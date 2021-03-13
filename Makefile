OBJ=obj
DEP=deps
BIN=bin

SRC=hello.c
OBJS=$(patsubst %.c, $(OBJ)/%.o, $(SRC))
DEPS=$(patsubst %.c, $(DEP)/%.d, $(SRC))

all: $(BIN)/hello

$(BIN)/hello: $(OBJS)

$(BIN)/%:
	$(CC) -o $@ $^ $(CCFLAGS) $(LDFLAGS)

$(OBJ)/%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

$(DEP)/%.d: %.c
	CMD="$$($(CC) -MM $< -MT $(patsubst %.c, $(OBJ)/%.o, $<))"; TARGET="$$(echo "$$CMD" | cut -d':' -f 1)"; echo "$$TARGET $@:$$(echo "$$CMD" | cut -d':' -f 2)" > $@

include $(DEPS)

clean:
	rm $(OBJ)/* $(BIN)/* $(DEP)/*
