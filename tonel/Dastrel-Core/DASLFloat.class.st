Class {
	#name : #DASLFloat,
	#superclass : #DASLLiteral,
	#category : #'Dastrel-Core'
}

{ #category : #parsing }
DASLFloat >> parse: aValue [
	| prefixSuffix |
	prefixSuffix := self splitLetterSuffix: aValue.
	self value: (Float readFromString: prefixSuffix first).
	self suffix: prefixSuffix second.
]
