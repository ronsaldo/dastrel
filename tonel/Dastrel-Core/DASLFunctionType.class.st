Class {
	#name : #DASLFunctionType,
	#superclass : #DASLType,
	#instVars : [
		'arguments',
		'returnType'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #construction }
DASLFunctionType class >> arguments: argumentTypes returnType: returnType [
	^ self new arguments: argumentTypes; returnType: returnType; yourself
]

{ #category : #comparing }
DASLFunctionType >> = other [
	^ self class == other class and: [ arguments = other arguments and: [ returnType = other returnType  ] ]
]

{ #category : #visitor }
DASLFunctionType >> accept: aVisitor [
	^ aVisitor visitFunctionType: self
]

{ #category : #accessing }
DASLFunctionType >> arguments [
	^ arguments
]

{ #category : #accessing }
DASLFunctionType >> arguments: anObject [
	arguments := anObject
]

{ #category : #converting }
DASLFunctionType >> createSlovimTypeFor: compilationTarget [
	^ SLVMFunctionType
		arguments: (arguments collect: [:arg | arg asSlovimType: compilationTarget])
		returnType: (returnType asSlovimType: compilationTarget)
]

{ #category : #comparing }
DASLFunctionType >> hash [
	^ (self class hash bitXor: arguments hash) bitXor: returnType hash
]

{ #category : #testing }
DASLFunctionType >> isFunctionType [
	^ true
]

{ #category : #printing }
DASLFunctionType >> printFunctionMangledOn: aStream [
	arguments do: [ :arg | arg printMangledOn: aStream ].
	arguments ifEmpty: [ aStream nextPut: $v ].
]

{ #category : #printing }
DASLFunctionType >> printMangledOn: aStream [
	aStream nextPut: $F.
	returnType printMangledOn: aStream.
	arguments do: [ :arg | arg printMangledOn: aStream ].
	arguments ifEmpty: [ aStream nextPut: $v ].
	aStream nextPut: $E.
]

{ #category : #printing }
DASLFunctionType >> printOn: aStream [
	aStream nextPutAll: 'function {('.
	arguments doWithIndex: [ :arg :index |
		index > 1 ifTrue: [ aStream nextPutAll: ', ' ].
		aStream print: arg.
	].
	aStream nextPutAll: ') ->';
		print: returnType;
		nextPutAll:  '}'
]

{ #category : #accessing }
DASLFunctionType >> returnType [
	^ returnType
]

{ #category : #accessing }
DASLFunctionType >> returnType: anObject [
	returnType := anObject
]
