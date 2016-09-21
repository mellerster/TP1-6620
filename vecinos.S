#include <mips/regdef.h>
	.align 2
	.text
	.globl	vecinos
	.ent vecinos
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
	subu 	sp,sp,16
	sw		$fp,FP(sp)	#Saved Registers Area.
	sw		gp,GP(sp)
	move	$fp,sp

	sw		a0,16(sp) #matriz	Argument building area.
	sw		a1,20(sp) #i
	sw		a2,24(sp) #j
	sw		a3,28(sp) #M
	#Asumo que N esta en 40(sp)
	sw		zero,V(sp)	#Local and temporary area
	li		v0,0
	lw		t0,I(sp)
	beqz 	t0,esprimerafila
	#si llego aca (i != 0)
	addu	t0,t0,-1 #t0 = i - 1
	lw		t1,N(sp)
	mul 	t0,t1 #lo = (i-1) * N
	mflo 	t0
	lw		t2,J(sp)
	add 	t0,t0,t2 # t0 = (i-1)*N+j
	lw		t1, A(sp)
	addu	t0,t1,t0 #t0 = direccion de a[(i-1)*N+j]
	lbu		t2, 0(t0) #t2 = a[(i-1)*N+j]
	li		t0, VACIO
	beq 	t2,t0,arribavacio
	lw		t0, V(sp)
	addu	t0,t0,1
	sw		t0, V(sp)
arribavacio:
	lw		t0, J(sp)
	beqz	t0,arribaizquierdavacio
	# j != 0
	addu	t0,t0,-1 #t0 = j-1
	lw		t1, I(sp)
	addu	t1,t1, -1 #t1 = i-1
	lw		t2, N(sp)
	mul		t1,t2
	mflo	t1
	add		t0,t0,t1 #t0 = (i-1)*N+j-1
	lw		t1, A(sp)
	addu	t0,t1,t0 #t0 = direccion de a[(i-1)*N+j-1]
	lbu		t2, 0(t0) #t2 = a[(i-1)*N+j-1]
	li		t1, VACIO
	beq 	t2,t1,arribaizquierdavacio
	lw		t0, V(sp)
	addu	t0,t0,1
	sw		t0, V(sp)
arribaizquierdavacio:
	lw		t0, J(sp)
	lw		t1, N(sp)
	addu	t1, t1, -1 # t1 = (N-1)
	beq		t0,t1,esprimerafila
	addu	t0,t0,1 #t0 = j+1
	lw		t1, I(sp)
	addu	t1,t1,-1 #t1 = i-1
	lw		t2, N(sp) #t2 = N
	mul		t1,t2
	mflo	t1 #t1 = (i-1)*N
	add		t0,t0,t1 #t0 = (i-1)*N+(j+1)
	lw		t1, A(sp)
	addu	t0,t1,t0 #t0 = direccion de a[(i-1)*N+j+1]
	lbu		t2, 0(t0) #t2 = a[(i-1)*N+j+1]
	li		t1, VACIO
	beq 	t2,t1,esprimerafila
	lw		t0, V(sp)
	addu	t0,t0,1
	sw		t0, V(sp)
esprimerafila:
	lw		t0,I(sp)
	lw		t1, M(sp)
	addu	t1,t1,-1 #t1 = M-1
	beq		t0,t1,esultimafila
	#chequeo abajo
	addu	t0,t0,-1 #t0 = i + 1
	lw		t1,N(sp)
	mul 	t0,t1 #lo = (i+1) * N
	mflo 	t0
	lw		t2,J(sp)
	add 	t0,t0,t2 # t0 = (i+1)*N+j
	lw		t1, A(sp)
	addu	t0,t1,t0 #t0 = direccion de a[(i-1)*N+j]
	lbu		t2, 0(t0) #t2 = a[(i+1)*N+j]
	li		t0, VACIO
	beq 	t2,t0,abajovacio
	lw		t0, V(sp)
	addu	t0,t0,1
	sw		t0, V(sp)
abajovacio:
	#abajo a la izquierda
	lw		t0, J(sp)
	beqz	t0, abajoizquierdavacio
	addu	t0,t0,-1 #t0 = j-1
	lw		t1, I(sp)
	addu	t1,t1, 1 #t1 = i+1
	lw		t2, N(sp)
	mul		t1,t2
	mflo	t1
	add		t0,t0,t1 #t0 = (i+1)*N+j-1
	lw		t1, A(sp)
	addu	t0,t1,t0 #t0 = direccion de a[(i+1)*N+j-1]
	lbu		t2, 0(t0) #t2 = a[(i+1)*N+j-1]
	li		t1, VACIO
	beq 	t2,t1,abajoizquierdavacio
	lw		t0, V(sp)
	addu	t0,t0,1
	sw		t0, V(sp)
abajoizquierdavacio:
	#abajo a la derecha
	lw		t0, J(sp)
	lw		t1, N(sp)
	addu	t1, t1, -1 # t1 = (N-1)
	beq		t0, t1, esultimafila
	addu	t0,t0,1 #t0 = j+1
	lw		t1, I(sp)
	addu	t1,t1, 1 #t1 = i+1
	lw		t2, N(sp)
	mul		t1,t2
	mflo	t1
	add		t0,t0,t1 #t0 = (i+1)*N+j+1
	lw		t1, A(sp)
	addu	t0,t1,t0 #t0 = direccion de a[(i+1)*N+j+1]
	lbu		t2, 0(t0) #t2 = a[(i+1)*N+j+1]
	li		t1, VACIO
	beq 	t2,t1,esultimafila
	lw		t0, V(sp)
	addu	t0,t0,1
	sw		t0, V(sp)
esultimafila:
	#tiene izquierda?
	lw		t0, J(sp)
	beqz	t0, notieneizquierda
	addu	t0,t0,-1 #t0 = j-1
	lw		t1, I(sp) #t1 = i
	lw		t2, N(sp)
	mul		t1,t2
	mflo	t1
	add		t0,t0,t1 #t0 = (i*N)+j-1
	lw		t1, A(sp)
	addu	t0,t1,t0 #t0 = direccion de a[i*N+j-1]
	lbu		t2, 0(t0) #t2 = a[i*N+j-1]
	li		t1, VACIO
	beq 	t2,t1,notieneizquierda
	lw		t0, V(sp)
	addu	t0,t0,1
	sw		t0, V(sp)
notieneizquierda:
	#tienederecha?
	lw		t0, J(sp)
	lw		t1, N(sp)
	addu	t1,t1,-1 #t1 = N-1
	beq		t0,t1,finvecinos
	addu	t0,t0,1 #t0 = j+1
	lw		t1, I(sp) #t1 = i
	lw		t2, N(sp)
	mul		t1,t2
	mflo	t1
	add		t0,t0,t1 #t0 = (i*N)+j+1
	lw		t1, A(sp)
	addu	t0,t1,t0 #t0 = direccion de a[i*N+j+1]
	lbu		t2, 0(t0) #t2 = a[i*N+j+1]
	li		t1, VACIO
	beq 	t2,t1,finvecinos
	lw		t0, V(sp)
	addu	t0,t0,1
	sw		t0, V(sp)
	j finvecinos
finvecinos:
	lw		v0, V(sp)
	#vacio el stack
	lw		$fp,FP(sp)
	lw  	gp,GP(sp)

	addu	sp,sp,16
	jr		ra

	.end	vecinos
