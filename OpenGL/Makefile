CC := g++

SRC_DIR := src
BIN_DIR := bin
INCLUDE_DIR := include
OBJ_DIR := obj

GLFW_FLAGS := -lglfw -lGL -lGLEW -lX11 -lXxf86vm -lXrandr -lpthread -lXi

FLAGS := -I $(INCLUDE_DIR) -std=c++11 -MMD -MP -Wall -lm $(GLFW_FLAGS)

SRC = $(wildcard $(SRC_DIR)/*.cpp)
OBJ := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRC))
EXE := $(BIN_DIR)/main

.PHONY: all clean

all: $(EXE)

$(EXE): $(OBJ) | $(BIN_DIR)
	$(CC) $(FLAGS) $^ -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CC) $(FLAGS) -c $< -o $@

$(BIN_DIR) $(OBJ_DIR):
	mkdir -p $@

clean:
	@$(RM) -rv $(BIN_DIR) $(OBJ_DIR)
