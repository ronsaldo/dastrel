Class {
	#name : #DASLTupleType,
	#superclass : #DASLType,
	#instVars : [
		'types'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #accessing }
DASLTupleType class >> types: typeList [
	^ self new types: typeList asArray; yourself
]

{ #category : #comparing }
DASLTupleType >> = other [
	^ self class == other class and: [ types = other types ]
]

{ #category : #visitor }
DASLTupleType >> accept: aVisitor [
	^ aVisitor visitTupleType: self
]

{ #category : #converting }
DASLTupleType >> createSlovimTypeFor: compilationTarget [
	^ SLVMTupleType types: (types collect: [ :arg | arg asSlovimType: compilationTarget ])

]

{ #category : #comparing }
DASLTupleType >> hash [
	^ self class hash bitXor: types hash
]

{ #category : #testing }
DASLTupleType >> isTupleType [
	^ true
]

{ #category : #accessing }
DASLTupleType >> types [
	^ types
]

{ #category : #accessing }
DASLTupleType >> types: anObject [
	types := anObject
]
