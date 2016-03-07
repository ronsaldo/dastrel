"
A DASLReferenceTypeTest is a test class for testing the behavior of DASLReferenceType
"
Class {
	#name : #DASLReferenceTypeTest,
	#superclass : #TestCase,
	#category : #'Dastrel-Tests'
}

{ #category : #tests }
DASLReferenceTypeTest >> testEqual [
	| refType1 refType2 |
	refType1 := DASLReferenceType baseType: DASLType intType.
	refType2 := DASLReferenceType baseType: DASLType intType.
	self assert: refType1 equals: refType2.
	self assert: refType1 hash equals: refType2 hash.
]

{ #category : #tests }
DASLReferenceTypeTest >> testNew [
	| baseType refType |
	baseType := DASLType intType.
	refType := DASLReferenceType baseType: baseType.
	self assert: refType baseType equals: baseType.
	self assert: refType isReferenceType
]

{ #category : #tests }
DASLReferenceTypeTest >> testNotEqual [
	| refType1 refType2 |
	refType1 := DASLReferenceType baseType: DASLType intType.
	refType2 := DASLReferenceType baseType: DASLType floatType.
	self deny: refType1 = refType2
]

{ #category : #tests }
DASLReferenceTypeTest >> testNotEqual2 [
	| refType |
	refType := DASLReferenceType baseType: DASLType intType.
	self deny: refType = DASLType intType.
]
