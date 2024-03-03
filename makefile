# компиляторы
CC := gcc
CCPP := g++

# пути
INC := app\inc
SRC := app\src
LA_INC := LA\inc
LA_SRC := LA\src
STD_OUT := out
OUT := $(STD_OUT)
OUT_R := $(OUT)\Release
OUT_D := $(OUT)\Debug

# флаги
CFLAGS := -std=c99 -Wall -Wextra -Wpedantic -DUNICODE -D_UNICODE
CPPFLAGS := -std=c++11 -Wall -Wextra -Wpedantic -DUNICODE -D_UNICODE
RSRCFLAGS := -I$(INC)

# условная сборка
mode := release

ifeq ($(mode), release)
	CFLAGS += -DNDEBUG -g0 -o3
	CPPFLAGS += -DNDEBUG -g0 -o3
	OUT := $(OUT_R)
endif

ifeq ($(mode), debug)
	CFLAGS += -D_DEBUG -g3
	CPPFLAGS += -D_DEBUG -g3
	OUT := $(OUT_D)
endif

# Какие объектные файлы мне нужны? начало ===================================================

# файлы приложения
APP_OBJ :=

# файлы библиотеки линейной алгебры
LA_OBJ :=

ifeq ($(filter app.exe,$(MAKECMDGOALS)), app.exe)
	APP_OBJ := $(patsubst $(SRC)/%.cpp,$(OUT)/%.o,$(wildcard $(SRC)/*.cpp))
endif

LA_OBJ := $(patsubst $(LA_SRC)/%.c,$(OUT)/%.o,$(wildcard $(LA_SRC)/*.c))

# Какие объектные файлы мне нужны? конец ==================================================

# Сборка начало ===========================================================================

# линковка программы (порядок библиотек имеет значение)
app.exe : $(APP_OBJ) LA.lib
	$(CCPP) -o $@ $^

# линковка библиотеки LA.lib
LA.lib : $(LA_OBJ)
	ar rcs $@ $^
	ranlib $@

# Сборка конец ===========================================================================

# Компоновка начало =======================================================================

# компиляция файлов основной программы
$(APP_OBJ) : $(OUT)/%.o : $(SRC)/%.cpp | out_folder
	$(CCPP) $(CPPFLAGS) -I$(INC) -I$(LA_INC) -c $< -o $@

# компиляция библиотеки
$(LA_OBJ) : $(OUT)/%.o : $(LA_SRC)/%.c | out_folder
	$(CC) $(CFLAGS) -I$(LA_INC) -c $< -o $@

# Компоновка конец =======================================================================

# Создать папку для объектников
.PHONY: out_folder
out_folder:
	@if not exist "$(OUT)" mkdir "$(OUT)"
	@if not exist "$(OUT_D)" mkdir "$(OUT_D)"
	@if not exist "$(OUT_R)" mkdir "$(OUT_R)"

# Очистка
.PHONY: clean
clean:
	@if exist ".\*.exe" del /q .\*.exe
	@if exist ".\*dll" del /q .\*dll
	@if exist ".\*lib" del /q .\*lib
	@if $(mode)==all (if exist "$(STD_OUT)" rd /s /q $(OUT)) else (if exist "$(OUT)" rd /s /q $(OUT))