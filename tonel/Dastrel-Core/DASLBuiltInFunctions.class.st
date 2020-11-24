Class {
	#name : #DASLBuiltInFunctions,
	#superclass : #Object,
	#category : #'Dastrel-Core-Builtin'
}

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInArithmeticFunctions [
	^ #(
		(
			(#'pre+') (expandToVector operation)
			(smallInt => int)
			(smallUInt => uint)
			(long => long)
			(ulong => ulong)
			(float => float)
			(double => double)
		)

		(
			(#'pre-') (expandToVector operation)
			(smallInt => int)
			(smallUInt => int)
			(long => long)
			(ulong => long)
			(float => float)
			(double => double)
		)
		
		(
			(#'pre~') (expandToVector operation)
			(smallInt => int)
			(smallUInt => uint)
			(long => long)
			(ulong => ulong)
		)
		
		(
			(+ - * / %) (ignoreOrder expandToVector operation)
			(smallInt smallInt => int)
			(smallUInt smallUInt => uint)
			(long long => long)
			(ulong ulong => ulong)
			(float float => float)
			(floatingPoint double => double)
			(integer float => float)
			(integer double => double)
		)

		(
			(& | ^ ~ << >>) (ignoreOrder expandToVector operation)
			(smallInt smallInt => int)
			(smallUInt smallUInt => uint)
			(long long => long)
			(ulong ulong => ulong)
		)
	
		((<= < > >=) (ignoreOrder operation)
			(smallInt smallInt => int => bool)
			(smallUInt smallUInt => uint => bool)
			(smallInt smallUInt => int => bool (warning) )
			(long long => long => bool)
			(ulong ulong => ulong => bool)
			(long ulong => long => bool (warning) )
			(float float => float => bool)
			(floatingPoint double => double => bool)
			(integer float => float => bool)
			(integer double => double => bool)
		)
	
		((== !=) (ignoreOrder expandToVector expandToMatrix operation)
			(smallIntAnySign smallIntAnySign => int => bool)
			(long long => long => bool)
			(ulong ulong => ulong => bool)
			(long ulong => long => bool (warning) )
			(float float => float => bool)
			(floatingPoint double => double => bool)
			(integer float => float => bool)
			(integer double => double => bool)
			(bool bool => bool)
		)
	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInBarrierFunctions [
	^ #(
		(
			((barrier #'shader.barrier.execution')) ()
			( => void)
		)

		(
			((memoryBarrier #'shader.barrier.memory.all')) ()
			( => void)
		)

		(
			((memoryBarrierAtomicCounter #'shader.barrier.memory.atomic_counter')) ()
			( => void)
		)

		(
			((memoryBarrierImage #'shader.barrier.memory.image')) ()
			( => void)
		)

		(
			((memoryBarrierBuffer #'shader.barrier.memory.buffer')) ()
			( => void)
		)

		(
			((memoryBarrierShared #'shader.barrier.memory.shared')) ()
			( => void)
		)

		(
			((groupMemoryBarrier #'shader.barrier.memory.group')) ()
			( => void)
		)

	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInCommon [
	^ #(
		(
			((min #'math.umin')
			(max #'math.umax')) (expandToVector)
			(uint uint => uint)
			(ulong ulong => ulong)
		)
		
		(
			((min #'math.smin')
			(max #'math.smax')) (expandToVector)
			(int int => int)
			(long long => long)
		)
		
		(
			((min #'math.fmin')
			(max #'math.fmax')) (expandToVector)
			(float float => float)
			(double double => double)
		)
	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInDerivativeFunctions [
	^ #(
		(
			((dFdx #'fragment.derivative.dx')) (expandToVector)
			(float => float)
			(double => double)
		)
		(
			((dFdy #'fragment.derivative.dy')) (expandToVector)
			(float => float)
			(double => double)
		)

		(
			((dFdxFine #'fragment.derivative.dx.fine')) (expandToVector)
			(float => float)
			(double => double)
		)
		(
			((dFdyFine #'fragment.derivative.dy.fine')) (expandToVector)
			(float => float)
			(double => double)
		)
		
		(
			((dFdxCoarse #'fragment.derivative.dx.coarse')) (expandToVector)
			(float => float)
			(double => double)
		)
		(
			((dFdyCoarse #'fragment.derivative.dy.coarse')) (expandToVector)
			(float => float)
			(double => double)
		)
		
		(
			((fwidth #'fragment.derivative.fwidth')) (expandToVector)
			(float => float)
			(double => double)
		)

		(
			((fwidthFine #'fragment.derivative.fwidth.fine')) (expandToVector)
			(float => float)
			(double => double)
		)

		(
			((fwidthCoarse #'fragment.derivative.fwidth.coarse')) (expandToVector)
			(float => float)
			(double => double)
		)

	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInFunctionPrototypes [
	^
		self builtInArithmeticFunctions,
		self builtInBarrierFunctions,
		self builtInLogicalFunctions,
		self builtInMatrixMultiplicationFunctions,
		self builtInMathFunctions,
		self builtInDerivativeFunctions,
		self builtInVectorFunctions,
		self builtInMatrixFunctions,
		self builtInTextureFunctions,
		self builtInImageFunctions,
		self builtInPackingFunctions,
		self builtInCommon
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInFunctions [
	^ DASLBuiltInFunctionPrototypeParser new parsePrototypes: self builtInFunctionPrototypes
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInImageFunctions [
	^ #(
		(
			((getImageSize #'texture.query.size')) ()
			(image1D => int)
			(image1DArray => int2)
			(image2D => int2)
			(image2DArray => int3)
			(image3D => int3)
			(imageCube => int2)
			(imageCubeArray => int3)
		)
		
		(
			((imageRead #'texture.image.read')) ()
			(image2D uint2 => float4)
			(image2D int2 => float4)
		)

		(
			((imageWrite #'texture.image.write')) ()
			(image2D uint2 float4 => void)
			(image2D int2 float4 => void)
		)
		
	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInLogicalFunctions [
	^ #(
		(
			(#'pre!') (operation)
			(bool => bool)
		)

		(
			(&& ||) (operation)
			(bool bool => bool)
		)
	
	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInMathFunctions [
	^ #(	
		(
			((smoothstep #'math.smoothstep')) (expandToVector)
			(float float float => float)
			(double double double => double)
		)

		(
			((step #'math.step')) (expandToVector)
			(float float => float)
			(double double => double)
		)
		
		(
			((mix #'math.fmix')) (expandToVector)
			(float float float => float)
			(double double double => double)
		)
		
		(
			((mod #'math.fmod')) (expandToVector)
			(float float => float)
			(double double => double)
		)
		
		(
			((pow #'math.pow')
			 (atan2 #'math.atan2')) (expandToVector)
			(float float => float)
			(double double => double)
		)
		
		(
			((asin #'math.asin')
			(sin #'math.sin')
			(asinh #'math.asinh')
			(sinh #'math.sinh')

			(acos #'math.acos')
			(cos #'math.cos')
			(acosh #'math.acosh')
			(cosh #'math.cosh')

			(atan #'math.atan')
			(tan #'math.tan')
			(atanh #'math.atanh')

			(exp #'math.exp')
			(exp2 #'math.exp2')
			(log #'math.log')
			(log2 #'math.log2')
			
			(sqrt #'math.sqrt')
			(inverseSqrt #'math.inverseSqrt')
			(floor #'math.floor')
			(ceil #'math.ceil')
			(trunc #'math.trunc')
			(round #'math.round')
			(roundEven #'math.roundEven')
			(fract #'math.fract')

			(degrees #'math.degrees')
			(radians #'math.radians')
			(fabs #'math.fabs')

			(sign #'math.fsign')) (expandToVector)
			(float => float)
			(double => double)
		)
	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInMatrixFunctions [
	^ #(
		(
			((transpose #'matrix.transpose')) ()
			(float3x3 float3x3 => float3x3)
			(float4x4 float4x4 => float4x4)
			
			(double3x3 double3x3 => double3x3)
			(double4x4 double4x4 => double4x4)
		)
	)

]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInMatrixMultiplicationFunctions [
	^ #(
		(
			(*) (operation matrixMatrix)
			(float4x4 float4x4 => float4x4)
			(float3x3 float3x3 => float3x3)
			(float2x2 float2x2 => float2x2)
		)
		
		(
			(*) (operation matrixVector)
			(float4x4 float4 => float4)
			(float4 float4x4 => float4)
			(float3x3 float3 => float3)
			(float3 float3x3 => float3)
			(float2x2 float2 => float2)
			(float2 float2x2 => float2)
		)
	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInPackingFunctions [
	^ #(
		(
			((packSnorm2x16 #'pack.snorm2x16')) ()
			(float2 => uint)
		)
		(
			((packUnorm2x16 #'pack.unorm2x16')) ()
			(float2 => uint)
		)
		(
			((packSnorm4x8 #'pack.snorm4x8')) ()
			(float4 => uint)
		)
		(
			((packUnorm4x8 #'pack.unorm4x8')) ()
			(float4 => uint)
		)

		(
			((unpackSnorm2x16 #'unpack.snorm2x16')) ()
			(uint => float2)
		)
		(
			((unpackUnorm2x16 #'unpack.unorm2x16')) ()
			(uint => float2)
		)
		
		(
			((unpackSnorm4x8 #'unpack.snorm4x8')) ()
			(uint => float2)
		)
		(
			((unpackUnorm4x8 #'unpack.unorm4x8')) ()
			(uint => float4)
		)

		(
			((packDouble2x32 #'pack.double2x32')) ()
			(double => uint2)
		)

		(
			((unpackDouble2x32 #'unpack.double2x32')) ()
			(uint2 => double)
		)
				
		(
			((packHalf2x16 #'pack.half2x16')) ()
			(float2 => uint)
		)

		(
			((unpackHalf2x16 #'unpack.half2x16')) ()
			(uint => float2)
		)

	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInSamplerFunctions [
	^ DASLBuiltInFunctionPrototypeParser new parsePrototypes: self builtInSamplerPrototypes
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInSamplerPrototypes [
	^ #(
		(
			(fetchTexelLod) (member)
			(texture1D int int => float4)
			(texture1DArray int2 int => float4)
			(texture2D int2 int => float4)
			(texture2DArray int3 int => float4)
			(texture3D int3 int => float4)
			(textureCube int3 int => float4)
			(textureCubeArray int4 int => float4)
		)

		
		(
			(sample) (member)
			(texture1D float => float4)
			(texture1DArray float2 => float4)
			(texture2D float2 => float4)
			(texture2DArray float3 => float4)
			(texture3D float3 => float4)
			(textureCube float3 => float4)
			(textureCubeArray float4 => float4)

			(depthTexture2D float2 => float)
			(depthTexture2DArray float3 => float)
			(depthTextureCube float3 => float)
			(depthTextureCubeArray float4 => float)
		)
		
		
		(
			(sampleLod) (member)
			(texture1D float float => float4)
			(texture1DArray float2 float => float4)
			(texture2D float2 float => float4)
			(texture2DArray float3 float => float4)
			(texture3D float3 float => float4)
			(textureCube float3 float => float4)
			(textureCubeArray float4 float => float4)

			(depthTexture2D float2 float => float)
			(depthTexture2DArray float3 float => float)
			(depthTextureCube float3 float => float)
			(depthTextureCubeArray float4 float => float)
		)
		
		(
			(sampleWithDepthReference) (member)
			(depthTexture2D float2 float => float)
			(depthTexture2DArray float3 float => float)
			(depthTextureCube float3 float => float)
			(depthTextureCubeArray float4 float => float)
		)
	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInTextureFunctions [
	^ #(
		(
			((getTextureSize #'texture.query.lod.size')) ()
			(texture1D int => int)
			(texture1DArray int => int2)
			(texture2D int => int2)
			(texture2DArray int => int3)
			(texture2DMS int => int2)
			(texture2DMSArray int => int3)
			(texture3D int => int3)
			(textureCube int => int2)
			(textureCubeArray int => int3)

			(depthTexture2D int => int2)
			(depthTexture2DArray int => int3)
			(depthTextureCube int => int2)
			(depthTextureCubeArray int => int3)
		)	

		(
			((getTextureSize #'texture.query.size')) ()
			(texture2DMS => int2)
			(texture2DMSArray => int3)
		)	

		(
			((getTextureLevelCount #'texture.query.lod.count')) ()
			(texture1D => int)
			(texture1DArray => int)
			(texture2D => int)
			(texture2DArray => int)
			(texture3D => int)
			(textureCube => int)
			(textureCubeArray => int)

			(depthTexture2D => int)
			(depthTexture2DArray => int)
			(depthTextureCube => int)
			(depthTextureCubeArray => int)
		)	

		(
			((texelFetch #'texture.image.fetch')) ()
			(texture2D uint2 => float4)
			(texture2D int2 => float4)

			(texture2DMS uint2 uint => float4)
			(texture2DMS int2 int => float4)
		)
	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInVectorFunctions [
	^ #(
		(
			((dot #'vector.dot')) ()
			(float2 float2 => float)
			(float3 float3 => float)
			(float4 float4 => float)
			
			(double2 double2 => double)
			(double3 double3 => double)
			(double4 double4 => double)
		)

		(
			((cross #'vector.cross')) ()
			(float3 float3 => float3)
			(double3 double3 => double3)
		)

		(
			((length #'vector.length')) ()
			(float2 => float)
			(float3 => float)
			(float4 => float)
			
			(double2 => double)
			(double3 => double)
			(double4 => double)
		)
		
		(
			((normalize #'vector.normalize')) ()
			(float2 => float2)
			(float3 => float3)
			(float4 => float4)
			
			(double2 => double2)
			(double3 => double3)
			(double4 => double4)
		)
		
		(
			((reflect #'vector.reflect')) (expandToVector)
			(float float => float)
			(double double => double)
		)

		(
			((refract #'vector.refract')) ()
			(float2 float2 float => float2)
			(float3 float3 float => float3)
			(float4 float4 float => float4)
			
			(double2 double2 double => double2)
			(double3 double3 double => double3)
			(double4 double4 double => double4)
		)
	)
]
