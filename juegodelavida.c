#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "vecinos.h"

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
    i = (unsigned int)atoi(argv[1]); //cantidad de ciclos
    M = (unsigned int)atoi(argv[2]);
    N = (unsigned int)atoi(argv[3]);
    char* matriz = malloc(M*N*sizeof(unsigned char));
    for(unsigned int a = 0; a < M*N; a++){
    		matriz[a] = ' ';
    }
    printf("Cantidad de repeticiones: %u\r\n",i);
    printf("Filas: %u\r\n",M);
    printf("Columnas: %u\r\n",N);
    //Armo matriz inicial
    
    //Recorro las iteraciones
    for(unsigned int j = 0; j < i; j++){
        //Vivir
    	for	(unsigned int a = 0; a < M; a++){
    		for(unsigned int b = 0; b < N; b++){
    			//Recorro los casilleros
    			unsigned int v = vecinos(matriz, a, b, M, N);
    			if(matriz[a*b] == ' '){
    				//Estaba muerta
    				if (v == 3){
    				}
    			} else {
    				//Estaba viva
    				if (v >=2 && v <= 3){
    					//sigue viva
    				} else {
    					//muere
    				}
    			}
    		}
    	}
        printf("Repetición %u\r\n",j);
    }
	printf("Finalizacion Exitosa\r\n");
    //Llamo a vecinos
    unsigned int prueba = vecinos((unsigned char*)&"hola",1,1,M,N);
    printf("%i\r\n %u\r\n",prueba,i);
    free(matriz);
    return 0;
}
