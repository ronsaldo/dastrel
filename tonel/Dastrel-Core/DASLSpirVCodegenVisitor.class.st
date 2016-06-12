Class {
	#name : #DASLSpirVCodegenVisitor,
	#superclass : #DASLAstVisitor,
	#category : #'Dastrel-Core-Codegen'
}

{ #category : #'as yet unclassified' }
DASLSpirVCodegenVisitor >> passOn: ast [
	| ssaModule |
	ssaModule := DASLSSACodegenVisitor passOn: ast.
	^ SLVMSpirVTranslator new translateSSAModule: ssaModule
]
