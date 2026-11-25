		.data
VALOR:	.word	30
		.code
		daddi r1, r0, 2
		sw r1, VALOR(r0)
		halt
	