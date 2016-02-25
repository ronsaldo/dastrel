Class {
	#name : #DASLexicalScope,
	#superclass : #DASLScope,
	#instVars : [
		'symbols',
		'node'
	],
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #accessing }
DASLexicalScope >> at: symbol put: symbolValue ifPresent: aBlock [
	(symbols includesKey: symbol) ifTrue: aBlock.
	symbols at: symbol put: symbolValue.
]

{ #category : #initialization }
DASLexicalScope >> initialize [
	super initialize.
	symbols := IdentityDictionary new.
]

{ #category : #'symbol lookup' }
DASLexicalScope >> lookSymbol: symbol [
	^ symbols at: symbol ifAbsent: [ ^ nil ]
]

{ #category : #accessing }
DASLexicalScope >> node [
	^ node
]

{ #category : #accessing }
DASLexicalScope >> node: anObject [
	node := anObject
]

{ #category : #accessing }
DASLexicalScope >> symbols [
	^ symbols
]
