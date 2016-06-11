Class {
	#name : #DASLCallBlockStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'results',
		'blockReference',
		'arguments'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #'as yet unclassified' }
DASLCallBlockStatement >> accept: visitor [
	^ visitor visitCallBlockStatement: self
]

{ #category : #accessing }
DASLCallBlockStatement >> arguments [
	^ arguments
]

{ #category : #accessing }
DASLCallBlockStatement >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
DASLCallBlockStatement >> blockReference [
	^ blockReference
]

{ #category : #accessing }
DASLCallBlockStatement >> blockReference: anObject [
	blockReference := anObject
]

{ #category : #accessing }
DASLCallBlockStatement >> results [
	^ results
]

{ #category : #accessing }
DASLCallBlockStatement >> results: anObject [
	results := anObject
]
