Class {
	#name : #DAIRAlloca,
	#superclass : #DAIRInstruction,
	#instVars : [
		'type',
		'valueType'
	],
	#classVars : [
		'OperationSignatures'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRAlloca class >> valueType: valueType [
	^ self new valueType: valueType
]

{ #category : #'as yet unclassified' }
DAIRAlloca >> mnemonic [
	^ 'alloca'
]

{ #category : #accessing }
DAIRAlloca >> type [
	^ type
]

{ #category : #accessing }
DAIRAlloca >> valueType [
	^ valueType
]

{ #category : #accessing }
DAIRAlloca >> valueType: aType [
	valueType := aType.
	type := DASLReferenceType baseType: valueType
]
