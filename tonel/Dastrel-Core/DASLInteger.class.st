Class {
	#name : #DASLInteger,
	#superclass : #DASLLiteral,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLInteger >> accept: aVisitor [
	^ aVisitor visitInteger: self
]

{ #category : #parsing }
DASLInteger >> parse: aValue [
	| prefixSuffix |
	prefixSuffix := self splitLetterSuffix: aValue.
	self value: prefixSuffix first asInteger.
	self suffix: prefixSuffix second.
]
