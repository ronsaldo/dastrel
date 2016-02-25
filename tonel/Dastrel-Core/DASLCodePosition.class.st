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
	^ self new
]

{ #category : #'instance creation' }
DASLCodePosition class >> fromToken: aPPToken [
	^ self new line: aPPToken line; column: aPPToken column; yourself
]

{ #category : #'instance creation' }
DASLCodePosition class >> fromToken: aPPToken fileName: fileName [
	^ self new fileName: fileName; line: aPPToken line; column: aPPToken column; yourself
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
