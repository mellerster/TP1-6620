#ifndef VACIO
#define VACIO 0
#endif
unsigned int vecinos(unsigned char *a,unsigned int i, unsigned int j, unsigned int M, unsigned int N){
    unsigned int v = 0;
    //Modelo Toroidal
    if(i != 0){
    	//Chequeo arriba
    	if (a[(i-1)*N+j] != VACIO){
    		v++;
    	}
    	//arriba a la izquierda
    	if (j != 0){
    		if (a[(i-1)*N+(j-1)] != VACIO){
				v++;
			}
    	} else {
    		if (a[(i-1)*N+(N-1)] != VACIO){
				v++;
			}
    	}
    	if (j != (N-1)){
    		//arriba a la derecha
			if (a[(i-1)*N+(j+1)] != VACIO){
				v++;
			}
    	} else {
			if (a[(i-1)*N] != VACIO){
				v++;
			}
    	}
    } else {
    	//Chequeo "arriba"
		if (a[(M-1)*N+j] != VACIO){
			v++;
		}
		//arriba a la izquierda
		if (j != 0){
			if (a[(M-1)*N+(j-1)] != VACIO){
				v++;
			}
		} else {
			if (a[(M-1)*N+(N-1)] != VACIO){
				v++;
			}
		}
		//arriba a la derecha
		if (j != (N-1)){
			if (a[(M-1)*N+(j+1)] != VACIO){
				v++;
			}
		} else {
			if (a[(M-1)*N] != VACIO){
				v++;
			}
		}
    }
    if (i != (M-1)){
    	//Chequeo abajo
    	if (a[(i+1)*N+j] != VACIO){
			v++;
		}
    	//abajo a la izquierda
    	if (j != 0){
			if (a[(i+1)*N+(j-1)] != VACIO){
				v++;
			}
		} else {
			if (a[(i+1)*N+(N-1)] != VACIO){
				v++;
			}
		}
    	//abajo a la derecha
		if (j != (N-1)){
			if (a[(i+1)*N+(j+1)] != VACIO){
				v++;
			}
		} else {
			if (a[(i+1)*N] != VACIO){
				v++;
			}
		}
    } else {
    	//Chequeo abajo
		if (a[j] != VACIO){
			v++;
		}
		//abajo a la izquierda
		if (j != 0){
			if (a[j-1] != VACIO){
				v++;
			}
		} else {
			if (a[N-1] != VACIO){
				v++;
			}
		}
		//abajo a la derecha
		if (j != (N-1)){
			if (a[j+1] != VACIO){
				v++;
			}
		} else {
			if (a[0] != VACIO){
				v++;
			}
		}
    }
    //Chequeo izquierda
    if (j != 0){
    	if (a[i*N+(j-1)] != VACIO){
			v++;
		}
    } else {
    	if (a[i*N+(N-1)] != VACIO){
			v++;
		}
    }
    //Chequeo derecha
    if (j != (N-1)){
		if (a[i*N+(j+1)] != VACIO){
			v++;
		}
	} else {
		if (a[i*N] != VACIO){
			v++;
		}
	}
    return v;
}
