Class {
	#name : #DASLType,
	#superclass : #DASLObject,
	#classVars : [
		'AtomicCounterStorage',
		'AutoType',
		'BoolType',
		'BuiltInTypes',
		'CharType',
		'CrossWorkgroupStorage',
		'DoubleType',
		'FloatType',
		'FunctionStorage',
		'GenericStorage',
		'ImageStorage',
		'InputStorage',
		'IntType',
		'LongType',
		'OutputStorage',
		'PrivateStorage',
		'PushConstantStorage',
		'SamplerType',
		'ShortType',
		'Textured1DArrayType',
		'Textured1DType',
		'Textured2DArrayType',
		'Textured2DType',
		'Textured3DArrayType',
		'Textured3DType',
		'UCharType',
		'UIntType',
		'ULongType',
		'UShortType',
		'UniformConstantStorage',
		'UniformStorage',
		'VoidType',
		'WorkgroupStorage'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #'storage classes' }
DASLType class >> atomicCounterStorage [
	^ AtomicCounterStorage
]

{ #category : #'built in types' }
DASLType class >> autoType [
	^ AutoType
]

{ #category : #'built in types' }
DASLType class >> boolType [
	^ BoolType
]

{ #category : #'class initialization' }
DASLType class >> builtInTypes [
	BuiltInTypes ifNil: [ self initialize. ].
	^ BuiltInTypes
]

{ #category : #'built in types' }
DASLType class >> charType [
	^ CharType
]

{ #category : #'storage classes' }
DASLType class >> crossWorkgroupStorage [
	^ CrossWorkgroupStorage
]

{ #category : #'built in types' }
DASLType class >> doubleType [
	^ DoubleType
]

{ #category : #'built in types' }
DASLType class >> floatType [
	^ FloatType
]

{ #category : #'storage classes' }
DASLType class >> functionStorage [
	^ FunctionStorage
]

{ #category : #'storage classes' }
DASLType class >> genericStorage [
	^ GenericStorage
]

{ #category : #'storage classes' }
DASLType class >> imageStorage [
	^ ImageStorage
]

{ #category : #'class initialization' }
DASLType class >> initialize [
	"
	self initialize
	"
	super initialize.
	
	UniformConstantStorage := #uniformConstant.
	UniformStorage := 	#uniform.
	InputStorage := #input.
	OutputStorage := #output.
	GenericStorage := #generic.
	WorkgroupStorage := #workgroup.
	CrossWorkgroupStorage := #crossWorkgroup.
	PrivateStorage := #private.
	FunctionStorage := #function.
	GenericStorage := #generic.
	PushConstantStorage := #pushConstant.
	AtomicCounterStorage := #atomicCounter.
	ImageStorage := #image.
	
	BuiltInTypes := IdentityDictionary new.
	(
		self primitiveTypes,
		self vectorTypes,
		self matrixTypes,
		self textureAndSamplerTypes
	) do: [ :type | BuiltInTypes at: type name put: type ]
	
]

{ #category : #'storage classes' }
DASLType class >> inputStorage [
	^ InputStorage
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
		DASLMatrixType baseType: FloatType rows: 2 columns: 2.
		DASLMatrixType baseType: FloatType rows: 3 columns: 3.
		DASLMatrixType baseType: FloatType rows: 4 columns: 4.
		
		DASLMatrixType baseType: DoubleType rows: 2 columns: 2.
		DASLMatrixType baseType: DoubleType rows: 3 columns: 3.
		DASLMatrixType baseType: DoubleType rows: 4 columns: 4.
	}
]

{ #category : #'storage classes' }
DASLType class >> outputStorage [
	^ OutputStorage
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

{ #category : #'storage classes' }
DASLType class >> privateStorage [
	^ PrivateStorage
]

{ #category : #'storage classes' }
DASLType class >> pushConstantStorage [
	^ PushConstantStorage
]

{ #category : #'built in types' }
DASLType class >> samplerType [
	^ SamplerType
]

{ #category : #'built in types' }
DASLType class >> shortType [
	^ ShortType
]

{ #category : #'built in types' }
DASLType class >> textureAndSamplerTypes [
	SamplerType := DASLSamplerType new name: #sampler.

	Textured1DType := DASLTextureType new name: #texture1D; sampledType: FloatType; dimensions: 1; array: false; depth: false; multisample: false; sampled: true.	
	Textured1DArrayType := DASLTextureType new name: #texture1DArray; sampledType: FloatType; dimensions: 1; array: true; depth: false; multisample: false; sampled: true.
	Textured2DType := DASLTextureType new name: #texture2D; dimensions: 2; sampledType: FloatType; array: false; depth: false; multisample: false; sampled: true.
	Textured2DArrayType := DASLTextureType new name: #texture2DArray; sampledType: FloatType; dimensions: 2; array: true; depth: false; multisample: false; sampled: true.
	Textured3DType := DASLTextureType new name: #texture3D; dimensions: 3; sampledType: FloatType; array: false; depth: false; multisample: false; sampled: true.
	Textured3DArrayType := DASLTextureType new name: #texture3DArray; sampledType: FloatType; dimensions: 3; array: true; depth: false; multisample: false; sampled: true.
	
	^ {
		SamplerType .
		Textured1DType .
		Textured1DArrayType .
		Textured2DType .
		Textured2DArrayType .
		Textured3DType .
		Textured3DType .
	}
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

{ #category : #'storage classes' }
DASLType class >> uniformConstantStorage [
	^ UniformConstantStorage
]

{ #category : #'storage classes' }
DASLType class >> uniformStorage [
	^ UniformStorage
]

{ #category : #'built in types' }
DASLType class >> ushortType [
	^ UShortType
]

{ #category : #'built in types' }
DASLType class >> vectorTypes [
	^ {
		DASLVectorType baseType: FloatType elements: 2.
		DASLVectorType baseType: FloatType elements: 3.
		DASLVectorType baseType: FloatType elements: 4.
		
		DASLVectorType baseType: DoubleType elements: 2.
		DASLVectorType baseType: DoubleType elements: 3.
		DASLVectorType baseType: DoubleType elements: 4.
	}
]

{ #category : #'built in types' }
DASLType class >> voidType [
	^ VoidType
]

{ #category : #'storage classes' }
DASLType class >> workgroupStorage [
	^ WorkgroupStorage
]

{ #category : #visitor }
DASLType >> accept: aVisitor [
	self subclassResponsibility
]

{ #category : #accessing }
DASLType >> alignment [
	self subclassResponsibility
]

{ #category : #converting }
DASLType >> asSlovimType [
	self subclassResponsibility
]

{ #category : #testing }
DASLType >> isArrayType [
	^ false
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
DASLType >> isSampledTextureType [
	^ false
]

{ #category : #testing }
DASLType >> isSamplerType [
	^ false
]

{ #category : #testing }
DASLType >> isSlovimType [
	^ false
]

{ #category : #testing }
DASLType >> isTextureType [
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
