Class {
	#name : #DASLPharoBlockConverterLexicalScope,
	#superclass : #DASLPharoBlockConverterScope,
	#instVars : [
		'symbols'
	],
	#category : #'Dastrel-PharoConverter'
}

{ #category : #adding }
DASLPharoBlockConverterLexicalScope >> addSymbol: symbol [
	symbols at: symbol name put: symbol
]

{ #category : #adding }
DASLPharoBlockConverterLexicalScope >> initialize [
	super initialize.
	symbols := Dictionary new.
]

{ #category : #adding }
DASLPharoBlockConverterLexicalScope >> lookSymbol: name [
	^ symbols at: name ifAbsent: [ nil ]
]

{ #category : #adding }
DASLPharoBlockConverterLexicalScope >> symbols [
	^ symbols
]
