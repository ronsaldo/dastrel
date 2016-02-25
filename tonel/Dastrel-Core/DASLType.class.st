Class {
	#name : #DASLType,
	#superclass : #DASLAstNode,
	#classVars : [
		'BuiltInTypes',
		'CharType',
		'DoubleType',
		'FloatType',
		'IntType',
		'LongType',
		'ShortType'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #'built in types' }
DASLType class >> builtInTypes [
	^ BuiltInTypes
]

{ #category : #'class initialization' }
DASLType class >> initialize [
	"
	self initialize
	"
	super initialize.
	
	BuiltInTypes := IdentityDictionary new.
	(self primitiveTypes , self vectorTypes)do: [ :type | BuiltInTypes at: type name put: type ]
]

{ #category : #'built in types' }
DASLType class >> primitiveTypes [
	CharType := DASLIntegerType name: #char size: 1 alignment: 1.
	ShortType := DASLIntegerType name: #short size: 2 alignment: 2.
	IntType := DASLIntegerType name: #int size: 4 alignment: 4.
	LongType := DASLIntegerType name: #long size: 8 alignment: 8.
	
	FloatType := DASLFloatType name: #float size: 4 alignment: 4.	
	DoubleType := DASLFloatType name: #double size: 8 alignment: 8.
	
	^ {
		CharType.
		ShortType.
		IntType.
		LongType.
		
		FloatType.
		DoubleType.
	}
]

{ #category : #'built in types' }
DASLType class >> vectorTypes [
	^ {
		DASLVectorType name: #float3 baseType: FloatType elements: 3 alignment: 16.
		DASLVectorType name: #float4 baseType: FloatType elements: 4 alignment: 16.
	}
]

{ #category : #accessing }
DASLType >> alignment [
	self subclassResponsibility
]

{ #category : #testing }
DASLType >> isBooleanType [
	^ false
]

{ #category : #testing }
DASLType >> isFloatType [
	^ false
]

{ #category : #testing }
DASLType >> isIntegerType [
	^ false
]

{ #category : #testing }
DASLType >> isOpaqueType [
	^ false
]

{ #category : #testing }
DASLType >> isPrimitiveType [
	^ false
]

{ #category : #testing }
DASLType >> isType [
	^ true
]

{ #category : #testing }
DASLType >> isTypeWrapper [
	^ false
]

{ #category : #testing }
DASLType >> isVoidType [
	^ false
]

{ #category : #accessing }
DASLType >> size [
	self subclassResponsibility
]

{ #category : #accessing }
DASLType >> type [
	^ DASLTypeWrapper new wrapped: self
]
