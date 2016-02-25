Class {
	#name : #DASLDiscardStatement,
	#superclass : #DASLStatement,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLDiscardStatement >> accept: aVisitor [
	^ aVisitor visitDiscardStatement: self
]

{ #category : #printing }
DASLDiscardStatement >> printOn: aStream [
	aStream nextPutAll: '(discard)'.
]
