Class {
	#name : #DASLCodePosition,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'line',
		'column'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #default }
DASLCodePosition class >> default [
	^ self new fileName: 'unknown'; line: 1; column: 1; yourself
]

{ #category : #'instance creation' }
DASLCodePosition class >> fromToken: aPPToken [
	^ self new line: aPPToken line; column: aPPToken column; yourself
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

{ #category : #accessing }
DASLCodePosition >> line [
	^ line
]

{ #category : #accessing }
DASLCodePosition >> line: anObject [
	line := anObject
]

{ #category : #accessing }
DASLCodePosition >> position [
	^ self
]
