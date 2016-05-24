Class {
	#name : #DASLUniformGlobal,
	#superclass : #DASLModule,
	#instVars : [
		'type',
		'codegenValue'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLUniformGlobal >> accept: visitor [
	^ visitor visitUniformGlobal: self.
]

{ #category : #accessing }
DASLUniformGlobal >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLUniformGlobal >> codegenValue: anObject [
	codegenValue := anObject
]

{ #category : #testing }
DASLUniformGlobal >> isUniformGlobal [
	^ true
]

{ #category : #accessing }
DASLUniformGlobal >> referenceType [
	^ DASLReferenceType baseType: self type storage: DASLType uniformConstantStorage
]

{ #category : #accessing }
DASLUniformGlobal >> type [
	^ type
]

{ #category : #accessing }
DASLUniformGlobal >> type: anObject [
	type := anObject
]
