Class {
	#name : #DASLLiteralType,
	#superclass : #DASLLiteral,
	#category : #'Dastrel-Core-AST'
}

{ #category : #construction }
DASLLiteralType class >> type: aType [
	^ self new value: (DASLTypeWrapper new wrapped: aType)
]

{ #category : #visitor }
DASLLiteralType >> accept: aVisitor [
	^ aVisitor visitLiteralType: self
]

{ #category : #visitor }
DASLLiteralType >> value: aTypeWrapper [
	super value: aTypeWrapper.
	type := aTypeWrapper.
	
]
