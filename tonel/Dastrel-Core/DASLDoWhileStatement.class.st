Class {
	#name : #DASLDoWhileStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'condition',
		'body'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLDoWhileStatement >> accept: aVisitor [
	^ aVisitor visitDoWhileStatement: self
]

{ #category : #accessing }
DASLDoWhileStatement >> body [
	^ body
]

{ #category : #accessing }
DASLDoWhileStatement >> body: anObject [
	body := anObject
]

{ #category : #accessing }
DASLDoWhileStatement >> condition [
	^ condition
]

{ #category : #accessing }
DASLDoWhileStatement >> condition: anObject [
	condition := anObject
]
