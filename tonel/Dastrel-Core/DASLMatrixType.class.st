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
	#category : #'Dastrel-Core-Type'
}

{ #category : #construction }
DASLMatrixType class >> baseType: aBaseType rows: numRows columns: numColumns [
	| alignmentMultiplier |
	alignmentMultiplier := numRows ~= 3 ifTrue: [ numRows ] ifFalse: [ 4 ].
	^ self baseType: aBaseType rows: numRows columns: numColumns alignment: aBaseType alignment * alignmentMultiplier
]

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

{ #category : #comparing }
DASLMatrixType >> = other [
	^ self class == other class
		and: [
			baseType = other baseType and:
			[ rows = other rows and:
			[ columns = other columns and:
			[ alignment = other alignment ] ] ] ]
]

{ #category : #visitor }
DASLMatrixType >> accept: aVisitor [
	^ aVisitor visitMatrixType: self
]

{ #category : #accessing }
DASLMatrixType >> alignment [
	^ alignment
]

{ #category : #accessing }
DASLMatrixType >> alignment: anObject [
	alignment := anObject
]

{ #category : #converting }
DASLMatrixType >> asSlovimType [
	^ SLVMMatrixType baseType: baseType asSlovimType rows: rows columns: columns alignment: alignment
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
DASLMatrixType >> columnType [
	^ DASLVectorType baseType: baseType elements: rows
]

{ #category : #accessing }
DASLMatrixType >> columns [
	^ columns
]

{ #category : #accessing }
DASLMatrixType >> columns: anObject [
	columns := anObject
]

{ #category : #comparing }
DASLMatrixType >> hash [
	^ (((self class hash bitXor: baseType hash) bitXor: rows hash) bitXor: columns hash) bitXor: alignment hash
]

{ #category : #testing }
DASLMatrixType >> isMatrixType [
	^ true
]

{ #category : #accessing }
DASLMatrixType >> memberAt: constantValue [
	^ self columnType
]

{ #category : #accessing }
DASLMatrixType >> name [
	^ self printString asSymbol
]

{ #category : #printing }
DASLMatrixType >> printOn: aStream [
	aStream print: baseType; print: rows; nextPut: $x; print: columns
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
