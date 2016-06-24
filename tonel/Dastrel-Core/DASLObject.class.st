Class {
	#name : #DASLObject,
	#superclass : #Object,
	#category : #'Dastrel-Core-AST'
}

{ #category : #'error reporting' }
DASLObject >> error: errorMessage at: position [
	DASLCompilationError new
		position: position;
		errorMessage: errorMessage;
		signal
]

{ #category : #'as yet unclassified' }
DASLObject >> isType [
	^ false
]
