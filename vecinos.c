

unsigned int vecinos(unsigned char *a,unsigned int i, unsigned int j, unsigned int M, unsigned int N){
    unsigned int v = 0;
    if(i != 0){
    	//Chequeo arriba
    	if (a[(i-1)*M+j] != ' '){
    		v++;
    	}
    	if (j != 0){
    		//arriba a la izquierda
    		if (a[(i-1)*M+(j-1)] != ' '){
				v++;
			}
    	}
    	if (j != (N-1)){
    		//arriba a la derecha
			if (a[(i-1)*M+(j+1)] != ' '){
				v++;
			}
    	}
    }
    if (i != (M-1)){
    	//Chequeo abajo
    	if (a[(i+1)*M+j] != ' '){
			v++;
		}
    	if (j != 0){
			//abajo a la izquierda
			if (a[(i+1)*M+(j-1)] != ' '){
				v++;
			}
		}
		if (j != (N-1)){
			//abajo a la derecha
			if (a[(i+1)*M+(j+1)] != ' '){
				v++;
			}
		}
    }
    if (j != 0){
    	//Chequeo izquierda
    	if (a[i*M+(j-1)] != ' '){
			v++;
		}
    }
    if (j != (N-1)){
		//Chequeo derecha
		if (a[i*M+(j+1)] != ' '){
			v++;
		}
	}
    return v;
}
