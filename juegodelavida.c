#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "vecinos.h"

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
			printf(" %c ",(matriz[pos] == ' ' ? 'x' : 'o'));
			if(j != (N-1)){
				printf("|");
			}
		}
		printf("\n");
	}
}

int main(int argc, char *argv[]) {
    unsigned int i = 0,M = 0,N = 0;
    if (argc < 4){
    	printf("Uso: ./juegodelavida <cantidad de ciclos> <filas matriz> <columnas matriz> <archivo de entrada> [<archivo de salida>]\r\n");
        return 1;
    } else if (argc == 4) {
        //Salida nombre default        
    } else if (argc == 5) {
        //Salida con nombre
    }
    FILE *fp;
	int n = AbrirArchivo(argv[4], &fp);
	if(n == 1){
		//No se pudo abrir el archivo
		printf("El archivo %s no pudo ser abierto.\r\n",argv[4]);
		return 1;
	}

    i = (unsigned int)atoi(argv[1]); //cantidad de ciclos
    M = (unsigned int)atoi(argv[2]);
    N = (unsigned int)atoi(argv[3]);
    if (M == 0){
    	printf("La cantidad de filas debe ser mayor a 0.\r\n");
    	return 1;
    }

    if (N == 0){
		printf("El tamaño de las columnas debe ser mayor a 0.\r\n");
		return 1;
	}

    unsigned char* matriz = malloc(M*N*sizeof(unsigned char));
    for(unsigned int a = 0; a < M*N; a++){
    		matriz[a] = ' ';
    }
    matriz[getPosicion(1,3,N)] = 'x';
    matriz[getPosicion(2,4,N)] = 'x';
    matriz[getPosicion(3,2,N)] = 'x';
    matriz[getPosicion(3,3,N)] = 'x';
    matriz[getPosicion(3,4,N)] = 'x';
    printf("Cantidad de repeticiones: %u\r\n",i);
    printf("Filas: %u\r\n",M);
    printf("Columnas: %u\r\n",N);
    //Armo matriz inicial
    //Recorro las iteraciones
    for(unsigned int j = 0; j < i; j++){
    	printf("iteración %u\n",j);
    	imprimirMatriz(matriz,M,N);
    	unsigned char* copia = malloc(M*N*sizeof(unsigned char));
        //Vivir
    	for	(unsigned int a = 0; a < M; a++){
    		for(unsigned int b = 0; b < N; b++){
    			//Recorro los casilleros
    			unsigned int v = vecinos(matriz, a, b, M, N);
    			unsigned int pos = getPosicion(a,b,N);
    			// printf("La posicion (%u,%u) posicion %u tiene %u vecinos\n",a,b,pos,v);
    			copia[pos] = matriz[pos];
    			if(matriz[pos] == ' '){
    				//Estaba muerta
    				if (v == 3){
    					copia[pos] = 'x';
    				}
    			} else {
    				//Estaba viva
    				if (v < 2 || v > 3){
    					//muere
    					copia[pos] = ' ';
    				}
    			}
    		}
    	}
    	free(matriz);
    	matriz = copia;
    }
	printf("Finalizacion Exitosa\r\n");
	imprimirMatriz(matriz,M,N);
    //Llamo a vecinos
    unsigned int prueba = vecinos((unsigned char*)&"hola",1,1,M,N);
    printf("%i\r\n %u\r\n",prueba,i);
    free(matriz);
    return 0;
}


