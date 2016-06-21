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
			(+ * / %) (ignoreOrder expandToVector operation)
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
			(-) (ignoreOrder expandToVector operation)
			(smallIntAnySign smallIntAnySign => int)
			(long long => long)
			(ulong ulong => ulong)
			(float float => float)
			(floatingPoint double => double)
			(integer float => float)
			(integer double => double)
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
DASLBuiltInFunctions class >> builtInCommon [
	^ #(
		(
			((min umin) (max umax)) (expandToVector)
			(uint uint => uint)
			(ulong ulong => ulong)
		)
		
		(
			((min smin) (max smax)) (expandToVector)
			(int int => int)
			(long long => long)
		)
		
		(
			((min fmin) (max fmax)) (expandToVector)
			(float float => float)
			(double double => double)
		)
	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInFunctionPrototypes [
	^
		self builtInArithmeticFunctions,
		self builtInLogicalFunctions,
		self builtInMatrixMultiplicationFunctions,
		self builtInMathFunctions,
		self builtInVectorFunctions,
		self builtInMatrixFunctions,
		self builtInCommon
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInFunctions [
	^ DASLBuiltInFunctionPrototypeParser new parsePrototypes: self builtInFunctionPrototypes
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
			(smoothstep step) (expandToVector)
			(float float float => float)
			(double double double => double)
		)

		(
			((mix fmix)) (expandToVector)
			(float float float => float)
			(double double double => double)
		)
		
		(
			(pow atan2) (expandToVector)
			(float float => float)
			(double double => double)
		)
		
		(
			(asin sin asinh sinh
			acos cos acosh cosh
			atan tan atanh
			exp exp2 log log2
			sqrt inverseSqrt
			floor ceil trunc round roundEven fract
			degrees radians 
			fabs
			(sign fsign)) (expandToVector)
			(float => float)
			(double => double)
		)
	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInMatrixFunctions [
	^ #(
		(
			(transpose) ()
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
		)
		
		(
			(*) (operation matrixVector)
			(float4x4 float4 => float4)
			(float4 float4x4 => float4)
			(float3x3 float3 => float3)
			(float3 float3x3 => float3)
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
			(sample) (member)
			(texture1D float => float4)
			(texture2D float2 => float4)
			(texture3D float3 => float4)
			(textureCube float3 => float4)
		)
	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInVectorFunctions [
	^ #(
		(
			(dot) ()
			(float2 float2 => float)
			(float3 float3 => float)
			(float4 float4 => float)
			
			(double2 double2 => double)
			(double3 double3 => double)
			(double4 double4 => double)
		)

		(
			(cross) ()
			(float3 float3 => float3)
			(double3 double3 => double3)
		)

		(
			(length) ()
			(float2 => float)
			(float3 => float)
			(float4 => float)
			
			(double2 => double)
			(double3 => double)
			(double4 => double)
		)
		
		(
			(normalize) ()
			(float2 => float2)
			(float3 => float3)
			(float4 => float4)
			
			(double2 => double2)
			(double3 => double3)
			(double4 => double4)
		)
		
		(
			(reflect) (expandToVector)
			(float float => float)
			(double double => double)
		)

		(
			(refract) ()
			(float2 float2 float => float2)
			(float3 float3 float => float3)
			(float4 float4 float => float4)
			
			(double2 double2 double => double2)
			(double3 double3 double => double3)
			(double4 double4 double => double4)
		)
	)
]
