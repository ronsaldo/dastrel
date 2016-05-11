Class {
	#name : #DASLIntegerType,
	#superclass : #DASLPrimitiveType,
	#instVars : [
		'signed'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #'as yet unclassified' }
DASLIntegerType class >> name: aName size: aSize alignment: anAlignment signed: aBoolean [
	^ (self name: aName size: aSize alignment: anAlignment) signed: aBoolean; yourself
]

{ #category : #comparing }
DASLIntegerType >> = other [
	^ super = other and: [ signed = other isSigned ]
]

{ #category : #visitor }
DASLIntegerType >> accept: aVisitor [
	^ aVisitor visitIntegerType: self
]

{ #category : #comparing }
DASLIntegerType >> hash [
	^ super hash bitXor: signed hash
]

{ #category : #initialization }
DASLIntegerType >> initialize [
	super initialize.
	signed := true.

]

{ #category : #testing }
DASLIntegerType >> isIntegerType [
	^ true
]

{ #category : #testing }
DASLIntegerType >> isSigned [
	^ signed
]

{ #category : #testing }
DASLIntegerType >> isUnsigned [
	^ signed not
]

{ #category : #accessing }
DASLIntegerType >> signed: anObject [
	signed := anObject
]
