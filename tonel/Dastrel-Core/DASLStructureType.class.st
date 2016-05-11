Class {
	#name : #DASLStructureType,
	#superclass : #DASLType,
	#instVars : [
		'types'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #'as yet unclassified' }
DASLStructureType class >> types: typeList [
	^ self new types: typeList; yourself
]

{ #category : #comparing }
DASLStructureType >> = other [
	^ self class == other class and: [ types = other types ]
]

{ #category : #comparing }
DASLStructureType >> hash [
	^ self class hash bitXor: types hash
]

{ #category : #testing }
DASLStructureType >> isStructureType [
	^ true
]

{ #category : #printing }
DASLStructureType >> printOn: aStream [
	aStream nextPutAll: 'struct {'.
	types doWithIndex: [ :type :index |
		index > 1 ifTrue: [ aStream nextPutAll: ', ' ].
		aStream print: type
	].
	aStream nextPutAll: '}'.
	
]

{ #category : #accessing }
DASLStructureType >> types [
	^ types
]

{ #category : #accessing }
DASLStructureType >> types: anObject [
	types := anObject
]
