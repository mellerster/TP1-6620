# Makefile de ejemplo para C/C++
# Creado: 15/04/2004 - Leandro Lucarella
# Modificado: 01/09/2016 - Pablo Roca
# Copyleft 2004 - Leandro Lucarella, Bajo licencia GPL [http://www.gnu.org/]

# CONFIGURACION
################

# Nombre del ejecutable.
target = conway

# Extensión de los archivos a compilar (c para C, cpp o cc o cxx para C++).
extension = c

# Archivos con el código fuente que componen el ejecutable. Si no se especifica,
# toma todos los archivos con la extensión mencionada. Para especificar hay que
# descomentar la línea (quitarle el '#' del principio).
# NOTA: No poner cabeceras (.h).
fuentes = juegodelavida.c vecinos.c

# Descomentar si se quiere ver como se invoca al compilador
#verbose = si


# CONFIGURACION "AVANZADA"
###########################

# Opciones para el compilador C/C++ para tratamiento de errores y warnings.
CFLAGS = -Wall
#
# Para optimizar el binario resultante lo mejor posible
CFLAGS += -O0

# Para valgrind o debug
CFLAGS += -ggdb -DDEBUG -fno-inline

# Opciones del enlazador.
#LDFLAGS =

# Estandar de C a usar
CSTD = c99


# VARIABLES CALCULADAS A PARTIR DE LA CONFIGURACION
####################################################

CFLAGS += -std=$(CSTD)
LD = $(CC)

# Si no especifica archivos, tomo todos.
fuentes ?= $(wildcard *.$(extension))
directorios = $(shell find . -type d -regex '.*\w+')

occ := $(CC)
orm := $(RM)
old := $(LD)
ifdef verbose
RM := $(RM) -v
else
CC =  @echo "  CC  $@"; $(occ)
RM =  @echo "  CLEAN"; $(orm)
LD =  @echo "  LD  $@"; $(old)
endif


# REGLAS
#########

.PHONY: all clean

all: $(target)

o_files = $(patsubst %.$(extension),%.o,$(fuentes))

$(target): $(o_files)
	@if [ -z "$(o_files)" ]; \
	then \
		echo "No hay archivos de entrada en el directorio actual. Recuerde que la extensión debe ser '.$(extension)' y que no se aceptan directorios anidados."; \
		if [ -n "$(directorios)" ]; then echo "Directorios encontrados: $(directorios)"; fi; \
		false; \
	fi >&2
	$(LD) $(o_files) -o $(target) $(LDFLAGS)

clean:
	$(RM) $(o_files) $(target)
	
asm:
	gcc -Wall -o $(target) vecinos.S juegodelavida.c

