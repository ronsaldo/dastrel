Class {
	#name : #DASLModule,
	#superclass : #DASLAstNode,
	#instVars : [
		'name',
		'inputs',
		'outputs',
		'scope',
		'attributes'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLModule >> attributes [
	^ attributes
]

{ #category : #accessing }
DASLModule >> attributes: aDictionary [
	attributes := aDictionary ifNotNil: [ aDictionary ] ifNil: [ Dictionary new ]
]

{ #category : #accessing }
DASLModule >> inputs [
	^ inputs
]

{ #category : #accessing }
DASLModule >> inputs: anObject [
	inputs := anObject
]

{ #category : #testing }
DASLModule >> isBuiltInFunction [
	^ false
]

{ #category : #testing }
DASLModule >> isCallableBlock [
	^ false
]

{ #category : #testing }
DASLModule >> isFunction [
	^ false
]

{ #category : #testing }
DASLModule >> isGraphBlock [
	^ false
]

{ #category : #accessing }
DASLModule >> name [
	^ name
]

{ #category : #accessing }
DASLModule >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DASLModule >> outputs [
	^ outputs
]

{ #category : #accessing }
DASLModule >> outputs: anObject [
	outputs := anObject
]

{ #category : #accessing }
DASLModule >> scope [
	^ scope
]

{ #category : #accessing }
DASLModule >> scope: anObject [
	scope := anObject
]
