Class {
	#name : #DASLPrimitiveType,
	#superclass : #DASLType,
	#instVars : [
		'name',
		'size',
		'alignment'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #'instance creation' }
DASLPrimitiveType class >> name: aName size: aSize alignment: anAlignment [
	^ self new name: aName; size: aSize; alignment: anAlignment; yourself
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

{ #category : #comparing }
DASLPrimitiveType >> hash [
	^ (self class hash bitXor: size hash) bitXor: alignment hash
]

{ #category : #testing }
DASLPrimitiveType >> isPrimitiveType [
	^ true
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
