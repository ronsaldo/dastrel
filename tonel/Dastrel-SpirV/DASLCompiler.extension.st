Extension { #name : #DASLCompiler }

{ #category : #'*Dastrel-SpirV' }
DASLCompiler >> spirVTarget [
	codeGenerator := DASLSpirVCodegenVisitor new.
]
