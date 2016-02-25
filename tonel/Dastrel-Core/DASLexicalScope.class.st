Class {
	#name : #DASLexicalScope,
	#superclass : #DASLScope,
	#instVars : [
		'symbols',
		'node',
		'useScopes'
	],
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #adding }
DASLexicalScope >> addUseScope: useScope [
	useScopes add: useScope.
]

{ #category : #accessing }
DASLexicalScope >> at: symbol put: symbolValue ifPresent: aBlock [
	(symbols includesKey: symbol) ifTrue: aBlock.
	symbols at: symbol put: symbolValue.
]

{ #category : #initialization }
DASLexicalScope >> initialize [
	super initialize.
	symbols := IdentityDictionary new.
	useScopes := OrderedCollection new.
]

{ #category : #'symbol lookup' }
DASLexicalScope >> lookSymbol: symbol [
	^ symbols at: symbol ifAbsent: [ ^ nil ]
]

{ #category : #'symbol lookup' }
DASLexicalScope >> lookSymbolRecursively: aSymbol [
	| result |
	result := super lookSymbolRecursively: aSymbol.
	result ifNotNil: [ ^ result  ].
	useScopes do: [ :scope |
		result := scope lookSymbolRecursively: aSymbol.
		result ifNotNil: [ ^ result ]
	].
	^ result.
	
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
