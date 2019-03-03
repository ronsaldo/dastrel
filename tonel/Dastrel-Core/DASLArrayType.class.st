Class {
	#name : #DASLArrayType,
	#superclass : #DASLType,
	#instVars : [
		'baseType',
		'elements'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #construction }
DASLArrayType class >> baseType: baseType elements: elements [
	^ self new baseType: baseType; elements: elements; yourself
]

{ #category : #comparing }
DASLArrayType >> = other [
	^ self class = other class and: [ baseType = other baseType and: [ elements = other elements ] ]
]

{ #category : #visitor }
DASLArrayType >> accept: aVisitor [
	^ aVisitor visitArrayType: self
]

{ #category : #accessing }
DASLArrayType >> alignment [
	^ baseType alignment
]

{ #category : #accessing }
DASLArrayType >> baseType [
	^ baseType
]

{ #category : #accessing }
DASLArrayType >> baseType: anObject [
	baseType := anObject
]

{ #category : #converting }
DASLArrayType >> createSlovimTypeFor: compilationTarget [
	^ SLVMArrayType
		baseType: (baseType asSlovimType: compilationTarget)
		elements: elements
]

{ #category : #accessing }
DASLArrayType >> elements [
	^ elements
]

{ #category : #accessing }
DASLArrayType >> elements: anObject [
	elements := anObject
]

{ #category : #'as yet unclassified' }
DASLArrayType >> generateSSAConstant: literalExpression withGenerator: codeGenerator [
	| slvmType |
	self assert: literalExpression isBlockListLiteral.
	self assert: literalExpression elements size = elements.

	slvmType := self asSlovimType: codeGenerator compilationTarget.
	^ SLVMConstant array: slvmType slots: (literalExpression elements collect: [:el |
		baseType generateSSAConstant: el withGenerator: codeGenerator
	])
]

{ #category : #comparing }
DASLArrayType >> hash [
	^ (self class hash bitXor: baseType hash) bitXor: elements hash
]

{ #category : #testing }
DASLArrayType >> isArrayType [
	^ true
]

{ #category : #testing }
DASLArrayType >> isBounded [
	^ elements isNotNil
]

{ #category : #accessing }
DASLArrayType >> memberAt: constantValue [
	^ baseType
]

{ #category : #printing }
DASLArrayType >> printMangledOn: aStream [
	aStream nextPut: $A.
	aStream print: (elements ifNil: [0]).
	aStream nextPut: $_.
	baseType printMangledOn: aStream.
	
]

{ #category : #printing }
DASLArrayType >> printOn: aStream [
	aStream print: baseType; nextPut: $[.
	elements ifNotNil: [ aStream print: elements ].
	aStream nextPut: $]
]

{ #category : #accessing }
DASLArrayType >> size [
	^ self isBounded ifTrue: [ baseType size * elements ] ifFalse: [ 0 ]
]
