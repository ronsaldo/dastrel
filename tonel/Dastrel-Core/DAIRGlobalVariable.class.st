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
DAIRGlobalVariable class >> name: aString valueType: aFunctionType [
	^ self new name: aString; valueType: aFunctionType; yourself
]

{ #category : #printing }
DAIRGlobalVariable >> fullPrintOn: aStream [
	aStream nextPutAll: 'global @'; print: type; space; nextPutAll: name; space.
	self printPropertiesOn: aStream.
	aStream cr
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
DAIRGlobalVariable >> valueType: aType [
	valueType := aType.
	type := DASLReferenceType baseType: valueType.
]
