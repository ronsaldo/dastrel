Class {
	#name : #DAIRGetElementReference,
	#superclass : #DAIRInstruction,
	#instVars : [
		'type'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRGetElementReference class >> reference: reference index: index [
	^ self new reference: reference index: index
]

{ #category : #visitor }
DAIRGetElementReference >> accept: aVisitor [
	^ aVisitor visitGetElementReference: self
]

{ #category : #accessing }
DAIRGetElementReference >> index [
	^ parameters second
]

{ #category : #printing }
DAIRGetElementReference >> mnemonic [
	^ 'getElementReference'
]

{ #category : #accessing }
DAIRGetElementReference >> reference [
	^ parameters first
]

{ #category : #construction }
DAIRGetElementReference >> reference: reference index: index [
	self parameters: { reference . index }.
	self assert: reference type isReferenceType.
	type := DASLReferenceType baseType: (reference type baseType memberAt: index) storage: reference type storage
]

{ #category : #accessing }
DAIRGetElementReference >> type [
	^ type
]
