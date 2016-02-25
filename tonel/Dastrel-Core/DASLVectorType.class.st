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
	#category : #'Dastrel-Core-AST'
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
