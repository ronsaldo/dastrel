Class {
	#name : #DASLIfStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'condition',
		'thenStatement',
		'elseStatement'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLIfStatement >> accept: visitor [
	^ visitor visitIfStatement: self
]

{ #category : #accessing }
DASLIfStatement >> condition [
	^ condition
]

{ #category : #accessing }
DASLIfStatement >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
DASLIfStatement >> elseStatement [
	^ elseStatement
]

{ #category : #accessing }
DASLIfStatement >> elseStatement: anObject [
	elseStatement := anObject
]

{ #category : #accessing }
DASLIfStatement >> thenStatement [
	^ thenStatement
]

{ #category : #accessing }
DASLIfStatement >> thenStatement: anObject [
	thenStatement := anObject
]
