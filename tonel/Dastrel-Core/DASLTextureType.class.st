Class {
	#name : #DASLTextureType,
	#superclass : #DASLOpaqueType,
	#instVars : [
		'sampledType',
		'dimensions',
		'array',
		'depth',
		'multisample',
		'sampled'
	],
	#category : #'Dastrel-Core-Type'
}

{ #category : #comparing }
DASLTextureType >> = other [
	^ self class = other class and: [
		sampledType = other sampledType and: [
			dimensions = other dimensions and: [
				array = other array and: [depth = other depth and: [
						multisample = other multisample and: [
							sampled = other sampled ]]]]]]
]

{ #category : #visitor }
DASLTextureType >> accept: aVisitor [
	^ aVisitor visitTextureType: self
]

{ #category : #accessing }
DASLTextureType >> array [
	^ array
]

{ #category : #accessing }
DASLTextureType >> array: anObject [
	array := anObject
]

{ #category : #converting }
DASLTextureType >> asSlovimType [
	^ SLVMTextureType new name: name; sampledType: sampledType asSlovimType; dimensions: dimensions; array: array; depth: depth; multisample: multisample; sampled: sampled; yourself
]

{ #category : #accessing }
DASLTextureType >> depth [
	^ depth
]

{ #category : #accessing }
DASLTextureType >> depth: anObject [
	depth := anObject
]

{ #category : #accessing }
DASLTextureType >> dimensions [
	^ dimensions
]

{ #category : #accessing }
DASLTextureType >> dimensions: anObject [
	dimensions := anObject
]

{ #category : #comparing }
DASLTextureType >> hash [
	^ (((((self class hash bitXor: dimensions hash)
			bitXor: sampledType hash)
			bitXor: array hash)
			bitXor: depth hash)
			bitXor: multisample hash)
			bitXor: sampled hash
]

{ #category : #testing }
DASLTextureType >> isTextureType [
	^ true
]

{ #category : #accessing }
DASLTextureType >> multisample [
	^ multisample
]

{ #category : #accessing }
DASLTextureType >> multisample: anObject [
	multisample := anObject
]

{ #category : #accessing }
DASLTextureType >> sampled [
	^ sampled
]

{ #category : #accessing }
DASLTextureType >> sampled: anObject [
	sampled := anObject
]

{ #category : #accessing }
DASLTextureType >> sampledType [
	^ sampledType
]

{ #category : #accessing }
DASLTextureType >> sampledType: anObject [
	sampledType := anObject
]
