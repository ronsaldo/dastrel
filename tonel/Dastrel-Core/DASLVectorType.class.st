Class {
	#name : #DASLVectorType,
	#superclass : #DASLType,
	#instVars : [
		'name',
		'baseType',
		'elements',
		'size',
		'alignment'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #construction }
DASLVectorType class >> baseType: aBaseType elements: numElements alignment: anAlignment [
	^ self new
		baseType: aBaseType;
		elements: numElements;
		alignment: anAlignment;
		size: (aBaseType size * numElements alignedTo: anAlignment);
		yourself
]

{ #category : #construction }
DASLVectorType class >> name: aName baseType: aBaseType elements: numElements alignment: anAlignment [
	^ (self baseType: aBaseType elements: numElements alignment: anAlignment) name: aName; yourself
]

{ #category : #comparing }
DASLVectorType >> = other [
	^ self class == other class
		and: [
			baseType = other baseType and:
			[ elements = other elements and:
			[ alignment = other alignment ] ] ]
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

{ #category : #accessing }
DASLVectorType >> elements [
	^ elements
]

{ #category : #accessing }
DASLVectorType >> elements: anObject [
	elements := anObject
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
	^ name
]

{ #category : #accessing }
DASLVectorType >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DASLVectorType >> size [
	^ size
]

{ #category : #accessing }
DASLVectorType >> size: anObject [
	size := anObject
]
