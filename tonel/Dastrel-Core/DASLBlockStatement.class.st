Class {
	#name : #DASLBlockStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'statements',
		'scope'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLBlockStatement >> accept: visitor [
	^ visitor visitBlockStatement: self
]

{ #category : #accessing }
DASLBlockStatement >> scope [
	^ scope
]

{ #category : #accessing }
DASLBlockStatement >> scope: anObject [
	scope := anObject
]

{ #category : #accessing }
DASLBlockStatement >> statements [
	^ statements
]

{ #category : #accessing }
DASLBlockStatement >> statements: anObject [
	statements := anObject
]
