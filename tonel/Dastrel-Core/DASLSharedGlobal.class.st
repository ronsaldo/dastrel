Class {
	#name : #DASLSharedGlobal,
	#superclass : #DASLModule,
	#instVars : [
		'type',
		'codegenValue'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLSharedGlobal >> accept: visitor [
	^ visitor visitSharedGlobal: self
]

{ #category : #accessing }
DASLSharedGlobal >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLSharedGlobal >> codegenValue: anObject [
	codegenValue := anObject
]

{ #category : #visitor }
DASLSharedGlobal >> isSharedGlobal [
	^ true
]

{ #category : #visitor }
DASLSharedGlobal >> referenceType [
	^ DASLReferenceType baseType: self type storage: DASLType uniformConstantStorage
]

{ #category : #accessing }
DASLSharedGlobal >> type [
	^ type
]

{ #category : #accessing }
DASLSharedGlobal >> type: anObject [
	type := anObject
]
