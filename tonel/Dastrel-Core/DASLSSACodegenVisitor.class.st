Class {
	#name : #DASLSSACodegenVisitor,
	#superclass : #DASLAstVisitor,
	#instVars : [
		'ssaModule'
	],
	#category : #'Dastrel-Core-Codegen'
}

{ #category : #visitor }
DASLSSACodegenVisitor >> visitTranslationUnit: translationUnit [
	ssaModule := DAIRModule new.
	^ ssaModule.
]
