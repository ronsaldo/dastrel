Class {
	#name : #DASLSpirVCodegenVisitor,
	#superclass : #DASLAstVisitor,
	#category : #'Dastrel-SpirV'
}

{ #category : #'as yet unclassified' }
DASLSpirVCodegenVisitor >> visitTranslationUnit: translationUnit [
	| ssaModule |
	ssaModule := translationUnit accept: (DASLSSACodegenVisitor new).
	^ DASLSSASpirVTranslator new translateSSAModule: ssaModule
]
