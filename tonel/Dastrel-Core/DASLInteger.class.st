Class {
	#name : #DASLInteger,
	#superclass : #DASLLiteral,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLInteger >> accept: aVisitor [
	^ aVisitor visitInteger: self
]

{ #category : #testing }
DASLInteger >> isLiteralInteger [
	^ true
]

{ #category : #parsing }
DASLInteger >> parse: aValue [
	| prefixSuffix |
	prefixSuffix := self splitLetterSuffix: aValue.
	self value: prefixSuffix first asInteger.
	self suffix: prefixSuffix second.
	type := self findTypeForSuffix: self suffix defaultType: DASLType intType.
	type isIntegerType ifFalse: [ self error: 'expected a suffix for an integer type.' at: self ].
]
