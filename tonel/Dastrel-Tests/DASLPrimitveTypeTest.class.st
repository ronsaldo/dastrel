Class {
	#name : #DASLPrimitveTypeTest,
	#superclass : #TestCase,
	#category : #'Dastrel-Tests'
}

{ #category : #tests }
DASLPrimitveTypeTest >> testEqualBool [
	self assert: DASLBoolType new equals: DASLBoolType new.
	self assert: DASLBoolType new hash equals: DASLBoolType new hash.

]

{ #category : #tests }
DASLPrimitveTypeTest >> testEqualFloat [
	| floatType1 floatType2 |
	floatType1 := DASLFloatType name: #dummy mangledName: #f size: 4 alignment: 4.
	floatType2 := DASLFloatType name: #dummy2 mangledName: #f size: 4 alignment: 4.
	self assert: floatType1 equals: floatType2.
	self assert: floatType1 hash equals: floatType2 hash.

]

{ #category : #tests }
DASLPrimitveTypeTest >> testEqualInteger [
	| intType1 intType2 |
	intType1 := DASLIntegerType name: #dummy mangledName: #i size: 4 alignment: 4.
	intType2 := DASLIntegerType name: #dummy2 mangledName: #i size: 4 alignment: 4.
	self assert: intType1 equals: intType2.
	self assert: intType1 hash equals: intType2 hash.
]

{ #category : #tests }
DASLPrimitveTypeTest >> testNewBool [
	| boolType |
	boolType := DASLBoolType new.
	self assert: boolType size equals: 4.
	self assert: boolType isBooleanType.
]

{ #category : #tests }
DASLPrimitveTypeTest >> testNewFloat [
	| floatType |
	floatType := DASLFloatType name: #dummy mangledName: #f size: 4 alignment: 4.
	self assert: floatType size equals: 4.
	self assert: floatType alignment equals: 4.
	self assert: floatType isFloatType.
]

{ #category : #tests }
DASLPrimitveTypeTest >> testNewInteger [
	| intType |
	intType := DASLIntegerType name: #dummy mangledName: #i size: 4 alignment: 4.
	self assert: intType size equals: 4.
	self assert: intType alignment equals: 4.
	self assert: intType isIntegerType.
]

{ #category : #tests }
DASLPrimitveTypeTest >> testNotEqualFloat [
	| floatType1 floatType2 |
	floatType1 := DASLFloatType name: #dummy mangledName: #f size: 4 alignment: 4.
	floatType2 := DASLFloatType name: #dummy2 mangledName: #d size: 8 alignment: 4.
	self deny: floatType1 = floatType2

]

{ #category : #tests }
DASLPrimitveTypeTest >> testNotEqualFloat2 [
	| floatType1 floatType2 |
	floatType1 := DASLFloatType name: #dummy mangledName: #d size: 8 alignment: 8.
	floatType2 := DASLFloatType name: #dummy2 mangledName: #d size: 8 alignment: 4.
	self deny: floatType1 = floatType2

]

{ #category : #tests }
DASLPrimitveTypeTest >> testNotEqualInteger [
	| intType1 intType2 |
	intType1 := DASLIntegerType name: #dummy mangledName: #i size: 4 alignment: 4.
	intType2 := DASLIntegerType name: #dummy2 mangledName: #i size: 8 alignment: 4.
	self deny: intType1 = intType2

]

{ #category : #tests }
DASLPrimitveTypeTest >> testNotEqualInteger2 [
	| intType1 intType2 |
	intType1 := DASLIntegerType name: #dummy mangledName: #i size: 8 alignment: 4.
	intType2 := DASLIntegerType name: #dummy2 mangledName: #i size: 8 alignment: 8.
	self deny: intType1 = intType2

]
