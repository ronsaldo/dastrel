Class {
	#name : #DASLType,
	#superclass : #DASLObject,
	#classVars : [
		'AutoType',
		'BoolType',
		'BuiltInTypes',
		'CharType',
		'DoubleType',
		'FloatType',
		'IntType',
		'LongType',
		'ShortType',
		'VoidType'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #'built in types' }
DASLType class >> autoType [
	^ AutoType
]

{ #category : #'built in types' }
DASLType class >> boolType [
	^ BoolType
]

{ #category : #'built in types' }
DASLType class >> builtInTypes [
	^ BuiltInTypes
]

{ #category : #'built in types' }
DASLType class >> doubleType [
	^ DoubleType
]

{ #category : #'built in types' }
DASLType class >> floatType [
	^ FloatType
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
DASLType class >> intType [
	^ IntType
]

{ #category : #'built in types' }
DASLType class >> primitiveTypes [
	AutoType := DASLAutoType new name: #auto.
	
	VoidType := DASLVoidType new name: #bool.
	BoolType := DASLBoolType name: #bool size: 1 alignment: 1.
	
	CharType := DASLIntegerType name: #char size: 1 alignment: 1.
	ShortType := DASLIntegerType name: #short size: 2 alignment: 2.
	IntType := DASLIntegerType name: #int size: 4 alignment: 4.
	LongType := DASLIntegerType name: #long size: 8 alignment: 8.
	
	FloatType := DASLFloatType name: #float size: 4 alignment: 4.	
	DoubleType := DASLFloatType name: #double size: 8 alignment: 8.
	
	^ {
		AutoType.
		
		VoidType.
		BoolType.
		
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

{ #category : #'built in types' }
DASLType class >> voidType [
	^ VoidType
]

{ #category : #accessing }
DASLType >> alignment [
	self subclassResponsibility
]

{ #category : #testing }
DASLType >> isAutoType [
	^ false
]

{ #category : #accessing }
DASLType >> isBlockType [
	^ false
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

{ #category : #accessing }
DASLType >> useScope [
	^ nil
]
