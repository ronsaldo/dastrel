Class {
	#name : #DASLMatrixType,
	#superclass : #DASLType,
	#instVars : [
		'name',
		'baseType',
		'rows',
		'columns',
		'size',
		'alignment'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #construction }
DASLMatrixType class >> baseType: aBaseType rows: numRows columns: numColumns alignment: anAlignment [
	^ self new
		baseType: aBaseType;
		rows: numRows;
		columns: numColumns;
		alignment: anAlignment;
		size: (aBaseType size * numColumns alignedTo: anAlignment) * numRows;
		yourself
]

{ #category : #construction }
DASLMatrixType class >> name: aName baseType: aBaseType rows: numRows columns: numColumns alignment: anAlignment [
	^ (self baseType: aBaseType rows: numRows columns: numColumns alignment: anAlignment) name: aName; yourself
]

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
DASLMatrixType >> name [
	^ name
]

{ #category : #accessing }
DASLMatrixType >> name: anObject [
	name := anObject
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
