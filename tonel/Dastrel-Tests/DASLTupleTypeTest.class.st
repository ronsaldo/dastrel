Class {
	#name : #DASLTupleTypeTest,
	#superclass : #TestCase,
	#category : #'Dastrel-Tests'
}

{ #category : #tests }
DASLTupleTypeTest >> testEqual [
	| tuple1 tuple2 |
	tuple1 := DASLTupleType types: { DASLType intType . DASLType floatType }.
	tuple2 := DASLTupleType types: { DASLType intType . DASLType floatType }.
	self assert: tuple1 equals: tuple2.
	self assert: tuple1 hash equals: tuple2 hash.
]

{ #category : #tests }
DASLTupleTypeTest >> testNew [
	| types tuple |
	types := { DASLType intType . DASLType floatType }.
	tuple := DASLTupleType types: types.
	self assert: tuple types equals: types.
	self assert: tuple isTupleType.
]

{ #category : #tests }
DASLTupleTypeTest >> testNotEqual [
	| tuple1 tuple2 |
	tuple1 := DASLTupleType types: { DASLType intType . DASLType floatType }.
	tuple2 := DASLTupleType types: { DASLType floatType . DASLType floatType }.
	self deny: tuple1 = tuple2
]

{ #category : #tests }
DASLTupleTypeTest >> testNotEqual2 [
	| tuple1 tuple2 |
	tuple1 := DASLTupleType types: { DASLType intType . DASLType floatType }.
	self deny: tuple1 = DASLType floatType
]
