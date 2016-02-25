Class {
	#name : #DASLFloat,
	#superclass : #DASLLiteral,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLFloat >> accept: aVisitor [
	^ aVisitor visitFloat: self
]

{ #category : #parsing }
DASLFloat >> parse: aValue [
	| prefixSuffix |
	prefixSuffix := self splitLetterSuffix: aValue.
	self value: (Float readFromString: prefixSuffix first).
	self suffix: prefixSuffix second.
]
