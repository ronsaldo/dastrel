Class {
	#name : #DASLPharoBlockConverterScope,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#category : #'Dastrel-PharoConverter'
}

{ #category : #accessing }
DASLPharoBlockConverterScope class >> parent: aParentScope [
	^ self new parent: aParentScope; yourself
]

{ #category : #'symbol lookup' }
DASLPharoBlockConverterScope >> lookSymbol: symbol [
	^ nil
]

{ #category : #'symbol lookup' }
DASLPharoBlockConverterScope >> lookSymbolRecursively: symbol [
	(self lookSymbol: symbol) ifNotNil: [ :found | ^ found ].
	^ parent ifNotNil: [ parent lookSymbolRecursively: symbol ]
]

{ #category : #'symbol lookup' }
DASLPharoBlockConverterScope >> lookSymbolRecursively: symbol ifAbsent: aBlock [
	^ (self lookSymbolRecursively: symbol)
		ifNil: [ aBlock value ]
]

{ #category : #accessing }
DASLPharoBlockConverterScope >> parent [
	^ parent
]

{ #category : #accessing }
DASLPharoBlockConverterScope >> parent: anObject [
	parent := anObject
]
