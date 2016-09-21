#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "vecinos.h"
#ifndef VACIO
#define VACIO 0
#endif
#define NOVACIO 1
int AbrirArchivo(char* path, FILE **fp) {
	*fp = fopen(path, "r");
	if(*fp == NULL)
		return 1;
	return 0;
}

int CrearArchivoOutput(char *archivo, FILE **fop) {
	if((*fop = fopen(archivo, "w+b")) == NULL) {
		/*Tiro error de apertura de archivo*/
		return 1;
	}
	return 0;
}

void ProcesarArchivo(FILE *fp) {
	/*char linea[MaxSizePanta];
	memset(linea, ' ', sizeof(linea));
	char *n;
	while(!feof(fp)) {
		n = fgets(linea, sizeof(linea), fp);
		if(n != NULL) {
		}
	}*/
}

void CerrarArchivo(FILE *fp) {
	fclose(fp);
}

unsigned int getPosicion(unsigned int i, unsigned int j, unsigned int N){
	return i*N+j;
}

void imprimirMatriz(unsigned char *matriz,unsigned int M,unsigned int N){
	for (unsigned int i = 0; i < M; i++){
		for (unsigned int j = 0; j < N; j++){
			unsigned int pos = getPosicion(i,j,N);
			printf(" %c ",(matriz[pos] == VACIO ? 'x' : 'o'));
			if(j != (N-1)){
				printf("|");
			}
		}
		printf("\n");
	}
}

void MostrarUso(){
	printf("Uso:\n");
	printf(" conway -h\n conway -V\n conway i M N inputfile [-o outputprefix]\n");
	printf("Opciones:\n -h, --help\t Imprime este mensaje\n");
	printf(" -V, --version\t Da la versión del programa\n");
	printf(" -o\tPrefijo de los archivos de salida\n");
}

void ImprimirError(char* msj){
	fprintf(stderr,"%s",msj);
}

void InvocacionIncorrecta(){
	ImprimirError("Invocación del programa incorrecta\n");
}

void GrabarArchivoSalida(unsigned char *matriz, unsigned int M, unsigned int N, char *prefijoSalida, unsigned int j) {
	unsigned int a = 0, b = 0;
	FILE *archivoSalida;
	char nombreArchivoSalida[50];
	char buf[5];
	printf("Grabando estado %s_%u.pbm\n",prefijoSalida,j);
	strcpy(nombreArchivoSalida,prefijoSalida);
	strcat(nombreArchivoSalida,"_");
	sprintf(buf, "%u", j);
	strcat(nombreArchivoSalida,buf),
	strcat(nombreArchivoSalida,".pbm");
	printf("%s\n",nombreArchivoSalida);
	printf("\n");
	CrearArchivoOutput(nombreArchivoSalida,&archivoSalida);
	//Grabar Encabezado de archivo
	printf("Grabo P1\n");
	fprintf(archivoSalida,"P1\n");
	printf("Grabo M = %u y N = %u\n",M,N);
	fprintf(archivoSalida,"%u %u\n",M,N);
	printf("Empiezo con las filas\n");
	//Recorrer Matriz y grabar archivo
	for(a = 0;a < M;a++){
		printf("grabo fila %u\n",a);
			for(b = 0;b < N;b++) {
				//Grabo posicion
				printf("Posicion: (%u,%u) = %u\n",a,b,getPosicion(a,b,N));
				fprintf(archivoSalida,"%u",matriz[getPosicion(a,b,N)]);
			}
			fprintf(archivoSalida,"\n");
	}
	//Cerrar archivo
	CerrarArchivo(archivoSalida);
}

void abortarCargaMatriz(char* mensaje, unsigned char* matriz, FILE* archivo) {
	ImprimirError(mensaje);
	free(matriz);
	CerrarArchivo(archivo);
    fclose(stdout);
	fclose(stderr);
	exit(-1);
}

unsigned char obtenerNumeroFila(unsigned char* matriz, FILE *archivo, unsigned int M) {
	unsigned char fila = 0;
	fscanf(archivo, "%hhu", &fila);
	if (fgetc(archivo) != ' ') {
		abortarCargaMatriz("\n\nError en el formato del archivo de entrada\n\n", matriz, archivo);
	}
	int proximoCaracter = fgetc(archivo);
	if (!((proximoCaracter >= '0') && (proximoCaracter <= '9'))) {
		abortarCargaMatriz("\n\nError en el formato del archivo de entrada\n\n", matriz, archivo);
	}
	fseek(archivo, -1, SEEK_CUR);
	if (fila > M-1) {
		abortarCargaMatriz("\n\nUn numero de fila en el archivo de entrada es mayor que el maximo permitido\n\n", matriz, archivo);
	}
	return fila;
}

unsigned char obtenerNumeroColumna(unsigned char* matriz, FILE *archivo, unsigned int N) {
	unsigned char columna = 0;
	fscanf(archivo, "%hhu", &columna);
	if (fgetc(archivo) != '\n') {
		abortarCargaMatriz("\n\nError en el formato del archivo de entrada\n\n", matriz, archivo);
	}
	int proximoCaracter = fgetc(archivo);
	if ((!((proximoCaracter >= '0') && (proximoCaracter <= '9'))) && (proximoCaracter != EOF)) {
		abortarCargaMatriz("\n\nError en el formato del archivo de entrada\n\n", matriz, archivo);
	}
	if (proximoCaracter != EOF) {
		fseek(archivo, -1, SEEK_CUR);
	}
	if (columna > N-1) {
		abortarCargaMatriz("\n\nUn numero de columna en el archivo de entrada es mayor que el maximo permitido\n\n", matriz, archivo);
	}
	return columna;
}

void cargarMatriz(unsigned char* matriz, FILE *archivo, unsigned int M, unsigned int N) {
	rewind(archivo);
	while (!feof(archivo)) {
		unsigned char fila = obtenerNumeroFila(matriz, archivo, M);
		unsigned char columna = obtenerNumeroColumna(matriz, archivo, N);
		matriz[fila*N + columna] = NOVACIO;
	}
}

int main(int argc, char *argv[]) {
    unsigned int i = 0,M = 0,N = 0,a = 0,n = 0,v,pos,j,b;
    char* prefijoSalida;
    FILE *fp;
    unsigned char* matriz;
    if (argc < 5){
    	if(argc == 2){
    		if (strcmp(argv[1],"-V") == 0|| strcmp(argv[1],"--version") == 0) {
    			printf("Version 1.0\n");
    			return 0;
    		} else if (strcmp(argv[1],"-h") == 0|| strcmp(argv[1],"--help") == 0) {
    			MostrarUso();
    			return 0;
    		} else {
    			InvocacionIncorrecta();
    			MostrarUso();
    			return 1;
    		}
    	} else {
    		InvocacionIncorrecta();
    		MostrarUso();
        	return 1;
    	}
    } else if (argc == 5 || argc == 7) {
    	i = (unsigned int)atoi(argv[1]); //cantidad de ciclos
    	if (i == 0){
			ImprimirError("La cantidad de estados (i) debe ser un número mayor a 0.\r\n");
			return 1;
		}
		M = (unsigned int)atoi(argv[2]);
	    if (M == 0){
	    	ImprimirError("La cantidad de filas (M) debe ser un número mayor a 0.\r\n");
	    	return 1;
	    }

	    N = (unsigned int)atoi(argv[3]);
	    if (N == 0){
	    	ImprimirError("El tamaño de las columnas (N) debe ser un número mayor a 0.\r\n");
			return 1;
		}

    } else {
    	InvocacionIncorrecta();
		MostrarUso();
		return 1;
    }

	prefijoSalida = argv[4];
	if(argc == 7){
		if(strcmp(argv[5],"-o") == 0){
			prefijoSalida = argv[6];
			if(strcmp(prefijoSalida,"") == 0){
				InvocacionIncorrecta();
				ImprimirError("El prefijo de los archivos de salida no puede ser vacio.");
				MostrarUso();
				return 1;
			}
		} else {
			InvocacionIncorrecta();
			MostrarUso();
			return 1;
		}
	}
	n = AbrirArchivo(argv[4], &fp);
	if(n == 1){
		//No se pudo abrir el archivo
		fprintf(stderr, "El archivo %s no pudo ser abierto.\r\n", argv[4]);
		return 1;
	}
	// Fin validaciones

	// Creo matriz
	matriz = malloc(M*N*sizeof(unsigned char));

	for(a = 0; a < M*N; a++){
		matriz[a] = VACIO;
    }
	/*matriz[getPosicion(1,2,N)] = NOVACIO;
	matriz[getPosicion(2,2,N)] = NOVACIO;
	matriz[getPosicion(3,2,N)] = NOVACIO;*/

	//Cargar matriz con archivo de entrada, en caso de tener errores no seguir y cerrar puntero y borrar matriz.
	cargarMatriz(matriz, fp, M, N);

	imprimirMatriz(matriz,M,N);
	GrabarArchivoSalida(matriz,M,N,prefijoSalida,0);
	//Recorro las iteraciones
    for(j = 0; j < i; j++){
    	unsigned char* copia = malloc(M*N*sizeof(unsigned char));
        //Vivir
    	for	(a = 0; a < M; a++){
    		for(b = 0; b < N; b++){
    			//Recorro los casilleros
    			v = vecinos(matriz, a, b, M, N);
    			pos = getPosicion(a,b,N);
    			copia[pos] = matriz[pos];
    			if(matriz[pos] == VACIO){
    				//Estaba muerta
    				if (v == 3){
    					copia[pos] = NOVACIO;
    				}
    			} else {
    				//Estaba viva
    				if (v < 2 || v > 3){
    					//muere
    					copia[pos] = VACIO;
    				}
    			}
    		}
    	}
    	free(matriz);
    	matriz = copia;
    	printf("iteración %u\n",j+1);
    	imprimirMatriz(matriz,M,N);
    	GrabarArchivoSalida(matriz,M,N,prefijoSalida,j+1);
    }
	printf("Listo\r\n");
    free(matriz);
    CerrarArchivo(fp);
    fclose(stdout);
	fclose(stderr);
    return 0;
}


