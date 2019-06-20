Class {
	#name : #DASLType,
	#superclass : #DASLObject,
	#instVars : [
		'slovimType'
	],
	#classVars : [
		'AtomicCounterStorage',
		'AutoType',
		'BoolType',
		'BuiltInTypes',
		'CharType',
		'CrossWorkgroupStorage',
		'DepthTexture2DArrayType',
		'DepthTexture2DType',
		'DepthTextureCubeArrayType',
		'DepthTextureCubeType',
		'DoubleType',
		'FloatType',
		'FunctionStorage',
		'GenericStorage',
		'Image1DArrayType',
		'Image1DType',
		'Image2DArrayType',
		'Image2DType',
		'Image3DArrayType',
		'Image3DType',
		'ImageCubeArrayType',
		'ImageCubeType',
		'ImageStorage',
		'InputStorage',
		'IntType',
		'LongType',
		'OutputStorage',
		'PrivateStorage',
		'PushConstantStorage',
		'SamplerType',
		'ShortType',
		'Texture1DArrayType',
		'Texture1DType',
		'Texture2DArrayType',
		'Texture2DType',
		'Texture3DArrayType',
		'Texture3DType',
		'TextureCubeArrayType',
		'TextureCubeType',
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
	
	VoidType := DASLVoidType new name: #void.
	BoolType := DASLBoolType name: #bool mangledName: #b size: 1 alignment: 1.
	
	CharType := DASLIntegerType name: #char mangledName: #a size: 1 alignment: 1.
	ShortType := DASLIntegerType name: #short mangledName: #s size: 2 alignment: 2.
	IntType := DASLIntegerType name: #int mangledName: #i size: 4 alignment: 4.
	LongType := DASLIntegerType name: #long mangledName: #l size: 8 alignment: 8.

	UCharType := DASLIntegerType name: #uchar mangledName: #h size: 1 alignment: 1 signed: false.
	UShortType := DASLIntegerType name: #ushort mangledName: #t size: 2 alignment: 2 signed: false.
	UIntType := DASLIntegerType name: #uint mangledName: #j size: 4 alignment: 4 signed: false.
	ULongType := DASLIntegerType name: #ulong mangledName: #m size: 8 alignment: 8 signed: false.
	
	FloatType := DASLFloatType name: #float mangledName: #f size: 4 alignment: 4.	
	DoubleType := DASLFloatType name: #double mangledName: #d size: 8 alignment: 8.
	
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

	Texture1DType := DASLTextureType new name: #texture1D; sampledType: FloatType; dimensions: 1; array: false; depth: false; multisample: false; sampled: true.	
	Texture1DArrayType := DASLTextureType new name: #texture1DArray; sampledType: FloatType; dimensions: 1; array: true; depth: false; multisample: false; sampled: true.
	Texture2DType := DASLTextureType new name: #texture2D; dimensions: 2; sampledType: FloatType; array: false; depth: false; multisample: false; sampled: true.
	Texture2DArrayType := DASLTextureType new name: #texture2DArray; sampledType: FloatType; dimensions: 2; array: true; depth: false; multisample: false; sampled: true.
	Texture3DType := DASLTextureType new name: #texture3D; dimensions: 3; sampledType: FloatType; array: false; depth: false; multisample: false; sampled: true.
	Texture3DArrayType := DASLTextureType new name: #texture3DArray; sampledType: FloatType; dimensions: 3; array: true; depth: false; multisample: false; sampled: true.
	TextureCubeType := DASLTextureType new name: #textureCube; dimensions: 4; sampledType: FloatType; array: false; depth: false; multisample: false; sampled: true.
	TextureCubeArrayType := DASLTextureType new name: #textureCubeArray; sampledType: FloatType; dimensions: 4; array: true; depth: false; multisample: false; sampled: true.

	DepthTexture2DType := DASLTextureType new name: #depthTexture2D; dimensions: 2; sampledType: FloatType; array: false; depth: true; multisample: false; sampled: true.
	DepthTexture2DArrayType := DASLTextureType new name: #depthTexture2DArray; sampledType: FloatType; dimensions: 2; array: true; depth: true; multisample: false; sampled: true.
	DepthTextureCubeType := DASLTextureType new name: #depthTextureCube; dimensions: 4; sampledType: FloatType; array: false; depth: true; multisample: false; sampled: true.
	DepthTextureCubeArrayType := DASLTextureType new name: #depthTextureCubeArray; sampledType: FloatType; dimensions: 4; array: true; depth: true; multisample: false; sampled: true.

	Image1DType := DASLTextureType new name: #image1D; sampledType: FloatType; dimensions: 1; array: false; depth: false; multisample: false; sampled: false.	
	Image1DArrayType := DASLTextureType new name: #image1DArray; sampledType: FloatType; dimensions: 1; array: true; depth: false; multisample: false; sampled: false.
	Image2DType := DASLTextureType new name: #image2D; dimensions: 2; sampledType: FloatType; array: false; depth: false; multisample: false; sampled: false.
	Image2DArrayType := DASLTextureType new name: #image2DArray; sampledType: FloatType; dimensions: 2; array: true; depth: false; multisample: false; sampled: false.
	Image3DType := DASLTextureType new name: #image3D; dimensions: 3; sampledType: FloatType; array: false; depth: false; multisample: false; sampled: false.
	Image3DArrayType := DASLTextureType new name: #image3DArray; sampledType: FloatType; dimensions: 3; array: true; depth: false; multisample: false; sampled: false.
	ImageCubeType := DASLTextureType new name: #imageCube; dimensions: 4; sampledType: FloatType; array: false; depth: false; multisample: false; sampled: false.
	ImageCubeArrayType := DASLTextureType new name: #imageCubeArray; sampledType: FloatType; dimensions: 4; array: true; depth: false; multisample: false; sampled: false.
	
	^ {
		SamplerType .
		
		Texture1DType .
		Texture1DArrayType .
		Texture2DType .
		Texture2DArrayType .
		Texture3DType .
		Texture3DArrayType .
		TextureCubeType .
		TextureCubeArrayType .
		
		DepthTexture2DType.
		DepthTexture2DArrayType.
		DepthTextureCubeType.
		DepthTextureCubeArrayType.
		
		Image1DType .
		Image1DArrayType .
		Image2DType .
		Image2DArrayType .
		Image3DType .
		Image3DArrayType .
		ImageCubeType .
		ImageCubeArrayType .
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
		
		DASLVectorType baseType: IntType elements: 2.
		DASLVectorType baseType: IntType elements: 3.
		DASLVectorType baseType: IntType elements: 4.
		
		DASLVectorType baseType: UIntType elements: 2.
		DASLVectorType baseType: UIntType elements: 3.
		DASLVectorType baseType: UIntType elements: 4.

		DASLVectorType baseType: ShortType elements: 2.
		DASLVectorType baseType: ShortType elements: 3.
		DASLVectorType baseType: ShortType elements: 4.

		DASLVectorType baseType: UShortType elements: 2.
		DASLVectorType baseType: UShortType elements: 3.
		DASLVectorType baseType: UShortType elements: 4.

		DASLVectorType baseType: CharType elements: 2.
		DASLVectorType baseType: CharType elements: 3.
		DASLVectorType baseType: CharType elements: 4.

		DASLVectorType baseType: UCharType elements: 2.
		DASLVectorType baseType: UCharType elements: 3.
		DASLVectorType baseType: UCharType elements: 4.
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
DASLType >> asDastrelTypeNode [
	^ DASLLiteralType type: self
]

{ #category : #converting }
DASLType >> asFunctionReferenceType [
	^ DASLReferenceType baseType: self storage: DASLType functionStorage
]

{ #category : #converting }
DASLType >> asSlovimType: compilationTarget [
	^ slovimType ifNil: [ slovimType := self createSlovimTypeFor: compilationTarget ]
]

{ #category : #converting }
DASLType >> createSlovimTypeFor: compilationTarget [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
DASLType >> emitPharoToDastrelMessage: messageNode receiver: receiverValue with: visitor [
	self error: 'Cannot convert message send {1}.' format: { messageNode selector printString } at: messageNode
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

{ #category : #printing }
DASLType >> printMangledOn: aStream [
	self subclassResponsibility
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

{ #category : #converting }
DASLType >> withoutReference [
	^ self
]
