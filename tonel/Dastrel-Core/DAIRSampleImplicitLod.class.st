Class {
	#name : #DAIRSampleImplicitLod,
	#superclass : #DAIRInstruction,
	#instVars : [
		'type'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRSampleImplicitLod class >> sampledTexture: sampledTexture texcoord: texcoord [
	^ self new sampledTexture: sampledTexture texcoord: texcoord
]

{ #category : #'as yet unclassified' }
DAIRSampleImplicitLod >> accept: aVisitor [
	^ aVisitor visitSampleImplicitLod: self
]

{ #category : #printing }
DAIRSampleImplicitLod >> mnemonic [
	^ #sampleImplicitLOD
]

{ #category : #accessing }
DAIRSampleImplicitLod >> sampledTexture [
	^ parameters first
]

{ #category : #construction }
DAIRSampleImplicitLod >> sampledTexture: sampledTexture texcoord: texcoord [
	self parameters: { sampledTexture . texcoord }.
	self flag: 'TODO: Support more result types than float4'.
	type := DASLType builtInTypes at: #float4.
	
]

{ #category : #accessing }
DAIRSampleImplicitLod >> texcoord [
	^ parameters second
]

{ #category : #accessing }
DAIRSampleImplicitLod >> type [
	^ type
]
