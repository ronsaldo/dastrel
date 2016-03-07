Class {
	#name : #DASLMatrixTypeTest,
	#superclass : #TestCase,
	#category : #'Dastrel-Tests'
}

{ #category : #tests }
DASLMatrixTypeTest >> testEqual [
	| matrixType1 matrixType2 |
	matrixType1 := DASLMatrixType baseType: DASLType intType rows: 2 columns: 2 alignment: 4.
	matrixType2 := DASLMatrixType baseType: DASLType intType rows: 2 columns: 2 alignment: 4.
	self assert: matrixType1 equals: matrixType2.
	self assert: matrixType1 hash equals: matrixType2 hash.

]

{ #category : #tests }
DASLMatrixTypeTest >> testNew [
	| matrixType baseType |
	baseType := DASLType intType.
	matrixType := DASLMatrixType baseType: baseType rows: 2 columns: 2 alignment: 4.
	self assert: matrixType baseType equals: baseType.
	self assert: matrixType rows equals: 2.
	self assert: matrixType columns equals: 2.
	self assert: matrixType size equals: 16.
	self assert: matrixType isMatrixType.
]

{ #category : #tests }
DASLMatrixTypeTest >> testNotEqual [
	| matrixType1 matrixType2 |
	matrixType1 := DASLMatrixType baseType: DASLType intType rows: 2 columns: 2 alignment: 4.
	matrixType2 := DASLMatrixType baseType: DASLType intType rows: 3 columns: 2 alignment: 4.
	self deny: matrixType1 = matrixType2.
	self deny: matrixType1 hash = matrixType2 hash.

]

{ #category : #tests }
DASLMatrixTypeTest >> testNotEqual2 [
	| matrixType1 matrixType2 |
	matrixType1 := DASLMatrixType baseType: DASLType intType rows: 2 columns: 2 alignment: 4.
	matrixType2 := DASLMatrixType baseType: DASLType intType rows: 2 columns: 3 alignment: 4.
	self deny: matrixType1 = matrixType2.
	self deny: matrixType1 hash = matrixType2 hash.

]

{ #category : #tests }
DASLMatrixTypeTest >> testNotEqual3 [
	| matrixType1 matrixType2 |
	matrixType1 := DASLMatrixType baseType: DASLType intType rows: 2 columns: 2 alignment: 4.
	matrixType2 := DASLMatrixType baseType: DASLType intType rows: 2 columns: 2 alignment: 8.
	self deny: matrixType1 = matrixType2.
	self deny: matrixType1 hash = matrixType2 hash.
]
