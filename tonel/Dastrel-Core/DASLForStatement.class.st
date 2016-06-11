Class {
	#name : #DASLForStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'initStatement',
		'condition',
		'increment',
		'body',
		'scope'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLForStatement >> accept: aVisitor [
	^ aVisitor visitForStatement: self
]

{ #category : #accessing }
DASLForStatement >> body [
	^ body
]

{ #category : #accessing }
DASLForStatement >> body: anObject [
	body := anObject
]

{ #category : #accessing }
DASLForStatement >> condition [
	^ condition
]

{ #category : #accessing }
DASLForStatement >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
DASLForStatement >> increment [
	^ increment
]

{ #category : #accessing }
DASLForStatement >> increment: anObject [
	increment := anObject
]

{ #category : #accessing }
DASLForStatement >> initStatement [
	^ initStatement
]

{ #category : #accessing }
DASLForStatement >> initStatement: anObject [
	initStatement := anObject
]

{ #category : #accessing }
DASLForStatement >> scope [
	^ scope
]

{ #category : #accessing }
DASLForStatement >> scope: anObject [
	scope := anObject
]
