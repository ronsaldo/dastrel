Class {
	#name : #DASLScope,
	#superclass : #Object,
	#instVars : [
		'parentScope'
	],
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #'symbol lookup' }
DASLScope >> lookSymbol: symbol [
	self subclassResponsibility
]

{ #category : #'symbol lookup' }
DASLScope >> lookSymbolRecursively: symbol [
	| result |
	result := self lookSymbol: symbol.
	result ifNotNil: [ ^ result ].
	^ parentScope ifNotNil: [ parentScope lookSymbolRecursively: symbol ]
]

{ #category : #accessing }
DASLScope >> parentScope [
	^ parentScope
]

{ #category : #accessing }
DASLScope >> parentScope: anObject [
	parentScope := anObject
]
