Class {
	#name : #DASLDiscardStatement,
	#superclass : #DASLStatement,
	#category : #'Dastrel-Core'
}

{ #category : #printing }
DASLDiscardStatement >> printOn: aStream [
	aStream nextPutAll: '(discard)'.
]
