Class {
	#name : #DASLCompilationError,
	#superclass : #Error,
	#instVars : [
		'position'
	],
	#category : #'Dastrel-Core-Error'
}

{ #category : #'error printing' }
DASLCompilationError >> compilationErrorMessage [
	^ position printString , ': ', messageText
]

{ #category : #accessing }
DASLCompilationError >> position [
	^ position
]

{ #category : #accessing }
DASLCompilationError >> position: anObject [
	position := anObject
]

{ #category : #'error printing' }
DASLCompilationError >> printCompilationError [
	Transcript show: self compilationErrorMessage; cr.
	FileStream stderr nextPutAll: self compilationErrorMessage; lf.

]
