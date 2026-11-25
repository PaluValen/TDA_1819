		.data
num1:	.word	75
num2:	.word	30
suma:	.word	0
resta:	.word	0
msuma:	.word	0
mresta:	.word	0
final:	.word	0
		.code
		lw r1, num1(r0)
		lw r2, num2(r0)
		nop
		nop
		nop
		dadd r3, r1, r2
		sw r3, suma(r0)
		dsub r4, r1, r2
		andi r5, r3, 0xF0
		sw r4, resta(r0)
		andi r6, r4, 0x0F
		sw r5, msuma(r0)
		sw r6, mresta(r0)
		orr r7, r5, r6
		sw r7, final(r0)
		halt
	