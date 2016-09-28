#include <mips/regdef.h>
	.text
	.align	2
	.global vecinos
	.ent	vecinos
#define V 0
#define GP 8
#define FP 12
#define A 16

#define I 20
#define J 24
#define M 28
#define N 32
#ifndef VACIO
#define VACIO 0
#endif
vecinos:
	#ABI
	subu	sp,sp,16
	sw		$fp,FP(sp)
	sw		gp,GP(sp)
	move	$fp,sp

	sw		a0,A(sp)
	sw		a1,I(sp)
	sw		a2,J(sp)
	sw		a3,M(sp)

	sw		zero,V(sp)
	#Empieza la función
	lw		t0,I(sp)
	beq		t0,zero,esprimerafila
	# i != 0
	lw		t0,I(sp)
	addu	t1,t0,-1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,J(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	lbu		t0,0(t0) #t0 = a[(i-1)*N+j]
	beq		t0,zero,verarrizq
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
verarrizq:
	lw		t0,J(sp)
	beq		t0,zero,verarrizqprimcol
	lw		t0,I(sp)
	addu	t1,t0,-1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,J(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	addu	t0,t0,-1
	lbu		t0,0(t0) #t0 = a[(i-1)*N+j-1]
	beq		t0,zero,verarrder
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
	b		verarrder
verarrizqprimcol:
	lw		t0,I(sp)
	addu	t1,t0,-1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,N(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	addu	t0,t0,-1
	lbu		t0,0(t0) #t0 = a[(i-1)*N+N-1]
	beq		t0,zero,verarrder
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
verarrder:
	lw		t0,N(sp)
	addu	t1,t0,-1
	lw		t0,J(sp)
	beq		t0,t1,verarrderultcol
	lw		t0,I(sp)
	addu	t1,t0,-1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,J(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	addu	t0,t0,1
	lbu		t0,0(t0) #t0 = a[(i-1)*N+j+1]
	beq		t0,zero,verultimafila
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
	b	verultimafila
verarrderultcol:
	lw		t0,I(sp)
	addu	t1,t0,-1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,A(sp)
	addu	t0,t1,t0
	lbu		t0,0(t0) #t0 = a[(i-1)*N]
	beq		t0,zero,verultimafila
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
	b		verultimafila
esprimerafila:
	lw		t0,M(sp)
	addu	t1,t0,-1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,J(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	lbu		t0,0(t0) #t0 = a[(M-1)*N+j]
	beq		t0,zero,verarribaizqpf
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
verarribaizqpf:
	lw		t0,J(sp)
	beq		t0,zero,verarribaizqprimcolprimfila
	lw		t0,M(sp)
	addu	t1,t0,-1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,J(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	addu	t0,t0,-1
	lbu		t0,0(t0) #t0 = a[(M-1)*N+j-1]
	beq		t0,zero,verarribaderpf
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
	b		verarribaderpf
verarribaizqprimcolprimfila:
	lw		t0,M(sp)
	addu	t1,t0,-1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,N(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	addu	t0,t0,-1
	lbu		t0,0(t0) #t0 = a[(M-1)*N+N-1]
	beq		t0,zero,verarribaderpf
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
verarribaderpf:
	lw		t0,N(sp)
	addu	t1,t0,-1
	lw		t0,J(sp)
	beq		t0,t1,verarribaderultcolpf
	lw		t0,M(sp)
	addu	t1,t0,-1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,J(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	addu	t0,t0,1
	lbu		t0,0(t0) #t0 = a[(M-1)*N+j+1]
	beq		t0,zero,verultimafila
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
	b		verultimafila
verarribaderultcolpf:
	lw		t0,M(sp)
	addu	t1,t0,-1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,A(sp)
	addu	t0,t1,t0
	lbu		t0,0(t0) #t0 = a[(M-1)*N]
	beq		t0,zero,verultimafila
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
verultimafila:
	lw		t0,M(sp)
	addu	t1,t0,-1
	lw		t0,I(sp)
	beq		t0,t1,verabajoultimafila
	lw		t0,I(sp)
	addu	t1,t0,1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,J(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	lbu		t0,0(t0) #t0 = a[(i+1)*N+j]
	beq		t0,zero,verabajoizqultfila
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
verabajoizqultfila:
	lw		t0,J(sp)
	beq		t0,zero,verabajoizqprimeracol
	lw		t0,I(sp)
	addu	t1,t0,1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,J(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	addu	t0,t0,-1
	lbu		t0,0(t0) #t0 = a[(i+1)*N+(j-1)]
	beq		t0,zero,verabajoderechaultfil
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
	b		verabajoderechaultfil
verabajoizqprimeracol:
	lw		t0,I(sp)
	addu	t1,t0,1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,N(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	addu	t0,t0,-1
	lbu		t0,0(t0) #t0 = a[(i+1)*N+(N-1)]
	beq		t0,zero,verabajoderechaultfil
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
verabajoderechaultfil:
	lw		t0,N(sp)
	addu	t1,t0,-1
	lw		t0,J(sp)
	beq		t0,t1,verproximafilacol0
	lw		t0,I(sp)
	addu	t1,t0,1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,J(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	addu	t0,t0,1
	lbu		t0,0(t0) #t0 = a[(i+1)*N+(j+1)]
	beq		t0,zero,verizquierda
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
	b		verizquierda
verproximafilacol0:
	lw		t0,I(sp)
	addu	t1,t0,1
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,A(sp)
	addu	t0,t1,t0
	lbu		t0,0(t0) #t0 = a[(i+1)*N]
	beq		t0,zero,verizquierda
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
	b		verizquierda
verabajoultimafila:
	lw		t1,A(sp)
	lw		t0,J(sp)
	addu	t0,t1,t0
	lbu		t0,0(t0) #t0 = a[j]
	beq		t0,zero,vercerocolanterior
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
vercerocolanterior:
	lw		t0,J(sp)
	beq		t0,zero,verceroabajodetodo
	lw		t1,A(sp)
	lw		t0,J(sp)
	addu	t0,t1,t0
	addu	t0,t0,-1
	lbu		t0,0(t0) #t0 = a[j-1]
	beq		t0,zero,ultfilaabajoder
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
	b		ultfilaabajoder
verceroabajodetodo:
	lw		t1,A(sp)
	lw		t0,N(sp)
	addu	t0,t1,t0
	addu	t0,t0,-1
	lbu		t0,0(t0) #t0 = a[N-1]
	beq		t0,zero,ultfilaabajoder
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
ultfilaabajoder:
	lw		t0,N(sp)
	addu	t1,t0,-1
	lw		t0,J(sp)
	beq		t0,t1,ver00
	lw		t1,A(sp)
	lw		t0,J(sp)
	addu	t0,t1,t0
	addu	t0,t0,1
	lbu		t0,0(t0) #t0 = a[j+1]
	beq		t0,zero,verizquierda
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
	b		verizquierda
ver00:
	lw		t0,A(sp)
	lbu		t0,0(t0) #to = a[0]
	beq		t0,zero,verizquierda
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
verizquierda:
	lw		t0,J(sp)
	beq		t0,zero,izqprimeracol
	lw		t1,I(sp)
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,J(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	addu	t0,t0,-1
	lbu		t0,0(t0) #t0 = a[i*N+(j-1)]
	beq		t0,zero,verderecha
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
	b		verderecha
izqprimeracol:
	lw		t1,I(sp)
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,N(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	addu	t0,t0,-1
	lbu		t0,0(t0) #t0 = a[i*N+(N-1)]
	beq		t0,zero,verderecha
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
verderecha:
	lw		t0,N(sp)
	addu	t1,t0,-1
	lw		t0,J(sp)
	beq		t0,t1,derultimafila
	lw		t1,I(sp)
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,J(sp)
	addu	t1,t1,t0
	lw		t0,A(sp)
	addu	t0,t1,t0
	addu	t0,t0,1
	lbu		t0,0(t0) #t0 = a[i*N+(j+1)]
	beq		t0,zero,finvecinos
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)
	b		finvecinos
derultimafila:
	lw		t1,I(sp)
	lw		t0,N(sp)
	mult	t1,t0
	mflo	t1
	lw		t0,A(sp)
	addu	t0,t1,t0
	lbu		t0,0(t0) #t0 = a[i*N]
	beq		t0,zero,finvecinos
	lw		t0,V(sp)
	addu	t0,t0,1
	sw		t0,V(sp)

finvecinos:
	lw		v0,V(sp)
	move	sp,$fp
	lw		$fp,FP(sp)
	lw		gp,GP(sp)
	addu	sp,sp,16
	j		ra
.end vecinos
