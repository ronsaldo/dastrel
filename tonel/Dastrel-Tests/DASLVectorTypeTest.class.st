Class {
	#name : #DASLVectorTypeTest,
	#superclass : #TestCase,
	#category : #'Dastrel-Tests'
}

{ #category : #tests }
DASLVectorTypeTest >> testEqual [
	| vectorType1 vectorType2 |
	vectorType1 := DASLVectorType baseType: DASLType intType elements: 2 alignment: 4.
	vectorType2 := DASLVectorType baseType: DASLType intType elements: 2 alignment: 4.
	self assert: vectorType1 equals: vectorType2.
	self assert: vectorType1 hash equals: vectorType2 hash.

]

{ #category : #tests }
DASLVectorTypeTest >> testNew [
	| vectorType baseType |
	baseType := DASLType intType.
	vectorType := DASLVectorType baseType: baseType elements: 2 alignment: 4.
	self assert: vectorType baseType equals: baseType.
	self assert: vectorType elements equals: 2.
	self assert: vectorType size equals: 8.
	self assert: vectorType isVectorType.
]

{ #category : #tests }
DASLVectorTypeTest >> testNotEqual [
	| vectorType1 vectorType2 |
	vectorType1 := DASLVectorType baseType: DASLType intType elements: 2 alignment: 4.
	vectorType2 := DASLVectorType baseType: DASLType floatType elements: 2 alignment: 4.
	self deny: vectorType1 = vectorType2

]

{ #category : #tests }
DASLVectorTypeTest >> testNotEqual2 [
	| vectorType1 vectorType2 |
	vectorType1 := DASLVectorType baseType: DASLType intType elements: 2 alignment: 4.
	vectorType2 := DASLVectorType baseType: DASLType intType elements: 3 alignment: 4.
	self deny: vectorType1 = vectorType2

]

{ #category : #tests }
DASLVectorTypeTest >> testNotEqual3 [
	| vectorType1 vectorType2 |
	vectorType1 := DASLVectorType baseType: DASLType intType elements: 2 alignment: 4.
	vectorType2 := DASLVectorType baseType: DASLType intType elements: 2 alignment: 8.
	self deny: vectorType1 = vectorType2

]

{ #category : #tests }
DASLVectorTypeTest >> testNotEqual4 [
	| vectorType |
	vectorType := DASLVectorType baseType: DASLType intType elements: 2 alignment: 4.
	self deny: vectorType = DASLType intType

]
