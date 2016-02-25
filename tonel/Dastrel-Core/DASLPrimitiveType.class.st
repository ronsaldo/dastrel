Class {
	#name : #DASLPrimitiveType,
	#superclass : #DASLType,
	#instVars : [
		'name',
		'size',
		'alignment'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #'instance creation' }
DASLPrimitiveType class >> name: aName size: aSize alignment: anAlignment [
	^ self new name: aName; size: aSize; alignment: anAlignment; yourself
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

{ #category : #accessing }
DASLPrimitiveType >> size [
	^ size
]

{ #category : #accessing }
DASLPrimitiveType >> size: anObject [
	size := anObject
]
