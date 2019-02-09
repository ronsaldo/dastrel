Class {
	#name : #DASLLiteral,
	#superclass : #DASLExpression,
	#instVars : [
		'value',
		'suffix',
		'type'
	],
	#classVars : [
		'LiteralSuffixTable'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #'class initialization' }
DASLLiteral class >> initialize [
	"
	self initialize
	"
	LiteralSuffixTable := Dictionary newFromPairs: #(
		u uint
		us ushort
		ul ulong
		
		s short
		l long
		f float
		l long
	).
]

{ #category : #parsing }
DASLLiteral class >> position: aPosition token: aString [
	^ self new position: aPosition; parse: aString; yourself
]

{ #category : #testing }
DASLLiteral >> evaluateConstant [
	^ self value
]

{ #category : #parsing }
DASLLiteral >> findTypeForSuffix: aSuffix defaultType: defaultType [
	| typeName |
	aSuffix ifEmpty: [ ^ defaultType ].
	typeName := LiteralSuffixTable at: aSuffix ifAbsent: [ self error: 'invalid literal suffix.' at: self ].
	^ DASLType builtInTypes at: typeName
]

{ #category : #testing }
DASLLiteral >> isConstantExpression [
	^ true
]

{ #category : #parsing }
DASLLiteral >> parse: aString [
	self subclassResponsibility
]

{ #category : #printing }
DASLLiteral >> printOn: aStream [
	value printOn: aStream
]

{ #category : #private }
DASLLiteral >> splitLetterSuffix: aString [
	| suffixStart extractedPrefix extractedSuffix |
	suffixStart := aString size + 1.
	[ suffixStart - 1 >= 1 and: [ (aString at: suffixStart - 1) isLetter ] ]
		whileTrue: [ suffixStart := suffixStart - 1].
	
	extractedPrefix := aString copyFrom: 1 to: (aString size min: suffixStart).
	extractedSuffix := aString copyFrom: suffixStart to: aString size.
	^ { extractedPrefix . extractedSuffix }
	
]

{ #category : #accessing }
DASLLiteral >> suffix [
	^ suffix
]

{ #category : #accessing }
DASLLiteral >> suffix: anObject [
	suffix := anObject
]

{ #category : #accessing }
DASLLiteral >> type [
	^ type
]

{ #category : #accessing }
DASLLiteral >> type: aType [
	type := aType
]

{ #category : #accessing }
DASLLiteral >> value [
	^ value
]

{ #category : #accessing }
DASLLiteral >> value: anObject [
	value := anObject
]
