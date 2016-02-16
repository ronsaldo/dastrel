Class {
	#name : #DASLCodePosition,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'line',
		'column'
	],
	#category : #'Dastrel-Core'
}

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

{ #category : #accessing }
DASLCodePosition >> line [
	^ line
]

{ #category : #accessing }
DASLCodePosition >> line: anObject [
	line := anObject
]
