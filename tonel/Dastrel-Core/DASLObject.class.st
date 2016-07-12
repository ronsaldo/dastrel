Class {
	#name : #DASLObject,
	#superclass : #Object,
	#category : #'Dastrel-Core-AST'
}

{ #category : #'error reporting' }
DASLObject >> error: errorMessage at: position [
	DASLCompilationError new
		position: position position;
		messageText: errorMessage;
		signal
]

{ #category : #testing }
DASLObject >> isType [
	^ false
]
