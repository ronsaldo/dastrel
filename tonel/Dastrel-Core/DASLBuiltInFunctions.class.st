Class {
	#name : #DASLBuiltInFunctions,
	#superclass : #Object,
	#category : #'Dastrel-Core-Builtin'
}

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInArithmeticFunctions [
	^ #(
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
	self builtInMatrixMultiplicationFunctions
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInFunctions [
	^ DASLBuiltInFunctionPrototypeParser new parsePrototypes: self builtInFunctionPrototypes
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInLogicalFunctions [
	^ #(
		(
			(!) (operation)
			(bool => bool)
		)

		(
			(&& ||) (operation)
			(bool bool => bool)
		)
	
	)
]

{ #category : #'builtin functions' }
DASLBuiltInFunctions class >> builtInMatrixMultiplicationFunctions [
	^ #(
		(
			(*) (operation)
			(float4x4 float4x4 => float4x4)
			(float3x3 float3x3 => float3x3)
			(float4x4 float4 => float4)
			(float4 float4x4 => float4)
			(float3x3 float3 => float3)
			(float3 float3x3 => float3)
		)
	)
]