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
		'UCharType',
		'UIntType',
		'ULongType',
		'UShortType',
		'VoidType'
	],
	#category : #'Dastrel-Core-Type'
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
DASLType class >> charType [
	^ CharType
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
	(self primitiveTypes , self vectorTypes , self matrixTypes )do: [ :type | BuiltInTypes at: type name put: type ]
]

{ #category : #'built in types' }
DASLType class >> intType [
	^ IntType
]

{ #category : #'built in types' }
DASLType class >> longType [
	^ LongType
]

{ #category : #'built in types' }
DASLType class >> matrixTypes [
	^ {
		DASLMatrixType name: #float3x3 baseType: FloatType rows: 3 columns: 3 alignment: 16.
		DASLMatrixType name: #float4x4 baseType: FloatType rows: 4 columns: 4 alignment: 16.
	}
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

	UCharType := DASLIntegerType name: #uchar size: 1 alignment: 1 signed: false.
	UShortType := DASLIntegerType name: #ushort size: 2 alignment: 2 signed: false.
	UIntType := DASLIntegerType name: #uint size: 4 alignment: 4 signed: false.
	ULongType := DASLIntegerType name: #ulong size: 8 alignment: 8 signed: false.
	
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

		UCharType.
		UShortType.
		UIntType.
		ULongType.
		
		FloatType.
		DoubleType.
	}
]

{ #category : #'built in types' }
DASLType class >> shortType [
	^ ShortType
]

{ #category : #'built in types' }
DASLType class >> ucharType [
	^ UCharType
]

{ #category : #'built in types' }
DASLType class >> uintType [
	^ UIntType
]

{ #category : #'built in types' }
DASLType class >> ulongType [
	^ ULongType
]

{ #category : #'built in types' }
DASLType class >> ushortType [
	^ UShortType
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
DASLType >> isFunctionGroupType [
	^ false
]

{ #category : #testing }
DASLType >> isFunctionType [
	^ false
]

{ #category : #testing }
DASLType >> isIntegerType [
	^ false
]

{ #category : #testing }
DASLType >> isMatrixType [
	^ false
]

{ #category : #testing }
DASLType >> isOpaqueType [
	^ false
]

{ #category : #testing }
DASLType >> isPlaceholderType [
	^ false
]

{ #category : #testing }
DASLType >> isPrimitiveType [
	^ false
]

{ #category : #testing }
DASLType >> isReferenceType [
	^ false
]

{ #category : #testing }
DASLType >> isTupleType [
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
DASLType >> isVectorType [
	^ false
]

{ #category : #testing }
DASLType >> isVoidType [
	^ false
]

{ #category : #accessing }
DASLType >> referenceType [
	^ DASLTypeWrapper new wrapped: self
]

{ #category : #accessing }
DASLType >> size [
	self subclassResponsibility
]

{ #category : #accessing }
DASLType >> useScope [
	^ nil
]
