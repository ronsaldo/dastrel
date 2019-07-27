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
	| prefixSuffix integerPart |
	prefixSuffix := self splitLetterSuffix: aValue.
	integerPart := prefixSuffix first.
	self value: (self parseIntegerPart: integerPart).
	self suffix: prefixSuffix second.
	type := self findTypeForSuffix: self suffix defaultType: DASLType intType.
	type isIntegerType ifFalse: [ self error: 'expected a suffix for an integer type.' at: self ].
]

{ #category : #parsing }
DASLInteger >> parseIntegerPart: integerPart [
	| sign string |
	sign := 1.
	string := integerPart.
	integerPart first = $- ifTrue: [
		sign := -1.
		string := string allButFirst.
	].

	(string beginsWith: '0x') ifTrue: [ 
		^ sign * (Integer readFrom: (string allButFirst: 2) base: 16)
	].

	(string first = $0) ifTrue: [ 
		^ sign * (Integer readFrom: string base: 8)
	].

	^ sign *string asInteger

]
