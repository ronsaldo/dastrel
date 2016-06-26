Class {
	#name : #DASLSpirVCodegenVisitor,
	#superclass : #DASLAstVisitor,
	#category : #'Dastrel-Core-Codegen'
}

{ #category : #'as yet unclassified' }
DASLSpirVCodegenVisitor >> passOn: ast optimizationLevel: optimizationLevel [
	| ssaModule |
	ssaModule := DASLSSACodegenVisitor new passOn: ast optimizationLevel: optimizationLevel.
	^ SLVMSpirVTranslator new translateSSAModule: ssaModule
]
