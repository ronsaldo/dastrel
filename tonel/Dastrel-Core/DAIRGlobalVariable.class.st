Class {
	#name : #DAIRGlobalVariable,
	#superclass : #DAIRGlobalValue,
	#instVars : [
		'valueType',
		'type'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRGlobalVariable class >> name: aString valueType: aFunctionType storage: storageClass [
	^ self new name: aString; valueType: aFunctionType storage: storageClass; yourself
]

{ #category : #visitor }
DAIRGlobalVariable >> accept: aVisitor [
	^ aVisitor visitGlobalVariable: self
]

{ #category : #printing }
DAIRGlobalVariable >> fullPrintOn: aStream [
	aStream nextPutAll: 'global @'; print: type; space; nextPutAll: name; space.
	self printPropertiesOn: aStream.
	aStream cr
]

{ #category : #testing }
DAIRGlobalVariable >> isGlobalVariable [
	^ true
]

{ #category : #accessing }
DAIRGlobalVariable >> type [
	^ type
]

{ #category : #accessing }
DAIRGlobalVariable >> valueType [
	^ valueType
]

{ #category : #accessing }
DAIRGlobalVariable >> valueType: aType storage: storageClass [
	valueType := aType.
	type := DASLReferenceType baseType: valueType storage: storageClass.
]
