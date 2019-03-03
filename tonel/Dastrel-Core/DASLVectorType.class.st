Class {
	#name : #DASLVectorType,
	#superclass : #DASLType,
	#instVars : [
		'baseType',
		'elements',
		'size',
		'alignment'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #construction }
DASLVectorType class >> baseType: aBaseType elements: numElements [
	| alignmentMultiplier |
	alignmentMultiplier := numElements ~= 3 ifTrue: [ numElements ] ifFalse: [ 4 ].
	^ self baseType: aBaseType elements: numElements alignment: aBaseType alignment * alignmentMultiplier
]

{ #category : #construction }
DASLVectorType class >> baseType: aBaseType elements: numElements alignment: anAlignment [
	^ self new
		baseType: aBaseType;
		elements: numElements;
		alignment: anAlignment;
		size: aBaseType size * numElements;
		yourself
]

{ #category : #comparing }
DASLVectorType >> = other [
	^ self class == other class
		and: [
			baseType = other baseType and:
			[ elements = other elements and:
			[ alignment = other alignment ] ] ]
]

{ #category : #visitor }
DASLVectorType >> accept: aVisitor [
	^ aVisitor visitVectorType: self
]

{ #category : #accessing }
DASLVectorType >> alignment [
	^ alignment
]

{ #category : #accessing }
DASLVectorType >> alignment: anObject [
	alignment := anObject
]

{ #category : #accessing }
DASLVectorType >> baseType [
	^ baseType
]

{ #category : #accessing }
DASLVectorType >> baseType: anObject [
	baseType := anObject
]

{ #category : #converting }
DASLVectorType >> createSlovimTypeFor: compilationTarget [
	^ SLVMVectorType
		baseType: (baseType asSlovimType: compilationTarget)
		elements: elements
		alignment: alignment
]

{ #category : #accessing }
DASLVectorType >> elements [
	^ elements
]

{ #category : #accessing }
DASLVectorType >> elements: anObject [
	elements := anObject
]

{ #category : #'as yet unclassified' }
DASLVectorType >> generateSSAConstant: literalExpression withGenerator: codeGenerator [
	| slvmType |
	self assert: literalExpression isBlockListLiteral.
	self assert: literalExpression elements size = elements.

	slvmType := self asSlovimType: codeGenerator compilationTarget.
	^ SLVMConstant vector: slvmType elements: (literalExpression elements collect: [:el |
		baseType generateSSAConstant: el withGenerator: codeGenerator
	])
]

{ #category : #comparing }
DASLVectorType >> hash [
	^ ((self class hash bitXor: baseType hash) bitXor: elements hash) bitXor: alignment hash
]

{ #category : #testing }
DASLVectorType >> isVectorType [
	^ true
]

{ #category : #accessing }
DASLVectorType >> name [
	^ self printString asSymbol
]

{ #category : #printing }
DASLVectorType >> printMangledOn: aStream [
	aStream nextPutAll: 'u2'.
	baseType printMangledOn: aStream.
	aStream print: elements
	
]

{ #category : #printing }
DASLVectorType >> printOn: aStream [
	aStream print: baseType; print: elements
]

{ #category : #accessing }
DASLVectorType >> size [
	^ size
]

{ #category : #accessing }
DASLVectorType >> size: anObject [
	size := anObject
]
