Class {
	#name : #DASLConstantGlobal,
	#superclass : #DASLModule,
	#instVars : [
		'initializationLiteral',
		'type',
		'codegenValue'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLConstantGlobal >> accept: visitor [
	^ visitor visitConstantGlobal: self
]

{ #category : #accessing }
DASLConstantGlobal >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLConstantGlobal >> codegenValue: anObject [
	codegenValue := anObject
]

{ #category : #accessing }
DASLConstantGlobal >> initializationLiteral [
	^ initializationLiteral
]

{ #category : #accessing }
DASLConstantGlobal >> initializationLiteral: anObject [
	initializationLiteral := anObject
]

{ #category : #testing }
DASLConstantGlobal >> isConstantGlobal [
	^ true
]

{ #category : #accessing }
DASLConstantGlobal >> referenceType [
	type isArrayType ifTrue: [ 
		^ DASLReferenceType baseType: self type storage: DASLType uniformConstantStorage
	].

	^ type

]

{ #category : #accessing }
DASLConstantGlobal >> type [
	^ type
]

{ #category : #accessing }
DASLConstantGlobal >> type: anObject [
	type := anObject
]
