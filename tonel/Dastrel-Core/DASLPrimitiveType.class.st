Class {
	#name : #DASLPrimitiveType,
	#superclass : #DASLType,
	#instVars : [
		'name',
		'size',
		'alignment',
		'mangledName'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #'instance creation' }
DASLPrimitiveType class >> name: aName mangledName: mangledName size: aSize alignment: anAlignment [
	^ self new name: aName; mangledName: mangledName; size: aSize; alignment: anAlignment; yourself
]

{ #category : #comparing }
DASLPrimitiveType >> = other [
	^ self class == other class and: [ size = other size and: [ alignment = other alignment ] ]
]

{ #category : #accessing }
DASLPrimitiveType >> alignment [
	^ alignment
]

{ #category : #accessing }
DASLPrimitiveType >> alignment: anObject [
	alignment := anObject
]

{ #category : #'as yet unclassified' }
DASLPrimitiveType >> generateSSAConstant: literalExpression withGenerator: codeGenerator [
	| ssaConstant |
	ssaConstant := literalExpression accept: codeGenerator.
	self assert: (ssaConstant type == (self asSlovimType: codeGenerator compilationTarget)).
	^ ssaConstant
]

{ #category : #comparing }
DASLPrimitiveType >> hash [
	^ (self class hash bitXor: size hash) bitXor: alignment hash
]

{ #category : #testing }
DASLPrimitiveType >> isPrimitiveType [
	^ true
]

{ #category : #accessing }
DASLPrimitiveType >> mangledName [
	^ mangledName
]

{ #category : #accessing }
DASLPrimitiveType >> mangledName: anObject [
	mangledName := anObject
]

{ #category : #accessing }
DASLPrimitiveType >> name [
	^ name
]

{ #category : #accessing }
DASLPrimitiveType >> name: anObject [
	name := anObject
]

{ #category : #printing }
DASLPrimitiveType >> printMangledOn: aStream [
	aStream nextPutAll: mangledName
]

{ #category : #printing }
DASLPrimitiveType >> printOn: aStream [
	aStream nextPutAll: name
]

{ #category : #accessing }
DASLPrimitiveType >> size [
	^ size
]

{ #category : #accessing }
DASLPrimitiveType >> size: anObject [
	size := anObject
]
