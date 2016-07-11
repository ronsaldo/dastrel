"
I represent a position in a source code file or stream. I am used mostly for printing error messages and for generating debug information.
"
Class {
	#name : #DASLCodePosition,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'offset',
		'line',
		'column'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #default }
DASLCodePosition class >> default [
	^ self new
]

{ #category : #accessing }
DASLCodePosition >> column [
	^ column
]

{ #category : #accessing }
DASLCodePosition >> column: anObject [
	column := anObject
]

{ #category : #accessing }
DASLCodePosition >> fileName [
	^ fileName
]

{ #category : #accessing }
DASLCodePosition >> fileName: anObject [
	fileName := anObject
]

{ #category : #'as yet unclassified' }
DASLCodePosition >> initialize [
	super initialize.
	fileName := 'unknown'.
	line := -1.
	column := -1.
]

{ #category : #accessing }
DASLCodePosition >> line [
	^ line
]

{ #category : #accessing }
DASLCodePosition >> line: anObject [
	line := anObject
]

{ #category : #accessing }
DASLCodePosition >> offset [
	^ offset
]

{ #category : #accessing }
DASLCodePosition >> offset: anObject [
	offset := anObject
]

{ #category : #accessing }
DASLCodePosition >> position [
	^ self
]

{ #category : #'as yet unclassified' }
DASLCodePosition >> printOn: aStream [
	aStream nextPutAll: fileName.
	aStream nextPut: $:.
	line printOn: aStream.
	aStream nextPut: $:.
	column printOn: aStream.
]
