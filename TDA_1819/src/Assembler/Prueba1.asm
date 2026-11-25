		.data
a:		.word	10
b:		.word	25
res1:	.word	0
res2:	.word	0
res3:	.hword	0
res4:	.byte	0
		.code
		lw r1, a(r0)
		lw r2, b(r0)
		dadd r3, r1, r2
		sw r3, res1(r0)
		dsub r4, r2, r1
		sw r4, res2(r0)
		dmul r5, r1, r2
		sh r5, res3(r0)
		andi r6, r5, 0xFF
		sb r6, res4(r0)
		halt
	