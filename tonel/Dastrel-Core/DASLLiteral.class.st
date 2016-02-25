Class {
	#name : #DASLLiteral,
	#superclass : #DASLExpression,
	#instVars : [
		'value',
		'suffix'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLLiteral class >> token: aPPToken [
	^ self new setPositionFromToken: aPPToken; parse: aPPToken inputValue; yourself
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
DASLLiteral >> value [
	^ value
]

{ #category : #accessing }
DASLLiteral >> value: anObject [
	value := anObject
]
