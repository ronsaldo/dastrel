Class {
	#name : #DASLWhileStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'condition',
		'body'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #'as yet unclassified' }
DASLWhileStatement >> accept: aVisitor [
	^ aVisitor visitWhileStatement: self
]

{ #category : #accessing }
DASLWhileStatement >> body [
	^ body
]

{ #category : #accessing }
DASLWhileStatement >> body: anObject [
	body := anObject
]

{ #category : #accessing }
DASLWhileStatement >> condition [
	^ condition
]

{ #category : #accessing }
DASLWhileStatement >> condition: anObject [
	condition := anObject
]
