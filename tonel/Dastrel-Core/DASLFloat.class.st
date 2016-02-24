Class {
	#name : #DASLFloat,
	#superclass : #DASLLiteral,
	#category : #'Dastrel-Core'
}

{ #category : #parsing }
DASLFloat >> parse: aValue [
	| prefixSuffix |
	prefixSuffix := self splitLetterSuffix: aValue.
	self value: prefixSuffix first asFloat.
	self suffix: prefixSuffix second.
]
