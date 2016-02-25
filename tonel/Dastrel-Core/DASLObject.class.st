Class {
	#name : #DASLObject,
	#superclass : #Object,
	#category : #'Dastrel-Core-AST'
}

{ #category : #'error reporting' }
DASLObject >> error: errorMessage at: position [
	self error: position position printString , ': ' , errorMessage
]
