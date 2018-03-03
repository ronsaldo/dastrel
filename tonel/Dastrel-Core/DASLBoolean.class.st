Class {
	#name : #DASLBoolean,
	#superclass : #DASLLiteral,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visiting }
DASLBoolean >> accept: aVisitor [
	^ aVisitor visitBoolean: self
]

{ #category : #initialization }
DASLBoolean >> initialize [
	super initialize.
	type := DASLType boolType
]
