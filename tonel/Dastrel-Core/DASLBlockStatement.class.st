Class {
	#name : #DASLBlockStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'pragmas',
		'statements',
		'scope'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLBlockStatement >> accept: visitor [
	^ visitor visitBlockStatement: self
]

{ #category : #testing }
DASLBlockStatement >> hasPragmaNamed: selector [
	^ pragmas anySatisfy: [ :p | p selector = selector ]
]

{ #category : #accessing }
DASLBlockStatement >> pragmas [
	^ pragmas
]

{ #category : #accessing }
DASLBlockStatement >> pragmas: anObject [
	pragmas := anObject
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
