Class {
	#name : #DASLSpirVCodegenVisitor,
	#superclass : #DASLAstVisitor,
	#category : #'Dastrel-SpirV'
}

{ #category : #'as yet unclassified' }
DASLSpirVCodegenVisitor >> passOn: ast [
	| ssaModule |
	ssaModule := DASLSSACodegenVisitor passOn: ast.
	^ DASLSSASpirVTranslator new translateSSAModule: ssaModule
]
