Class {
	#name : #DASLMatrixType,
	#superclass : #DASLType,
	#instVars : [
		'baseType',
		'rows',
		'columns',
		'size',
		'alignment'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLMatrixType >> alignment [
	^ alignment
]

{ #category : #accessing }
DASLMatrixType >> alignment: anObject [
	alignment := anObject
]

{ #category : #accessing }
DASLMatrixType >> baseType [
	^ baseType
]

{ #category : #accessing }
DASLMatrixType >> baseType: anObject [
	baseType := anObject
]

{ #category : #accessing }
DASLMatrixType >> columns [
	^ columns
]

{ #category : #accessing }
DASLMatrixType >> columns: anObject [
	columns := anObject
]

{ #category : #accessing }
DASLMatrixType >> rows [
	^ rows
]

{ #category : #accessing }
DASLMatrixType >> rows: anObject [
	rows := anObject
]

{ #category : #accessing }
DASLMatrixType >> size [
	^ size
]

{ #category : #accessing }
DASLMatrixType >> size: anObject [
	size := anObject
]
