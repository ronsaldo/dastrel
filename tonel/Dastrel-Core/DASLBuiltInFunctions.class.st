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
			(+ * %) (ignoreOrder expandToVector operation)
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
DASLBuiltInFunctions class >> builtInFunctionPrototypes [
	^ self builtInArithmeticFunctions , self builtInLogicalFunctions ,
	self builtInMatrixMultiplicationFunctions ,
	self builtInMathFunctions
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
			(smoothstep) (expandToVector)
			(float float float => float)
			(double double double => double)
		)
		(
			(smoothstep) ()
			(float float float2 => float2)
			(float float float3 => float3)
			(float float float4 => float4)
			(double double double2 => double2)
			(double double double3 => double3)
			(double double double4 => double4)
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
		)
	)
]
