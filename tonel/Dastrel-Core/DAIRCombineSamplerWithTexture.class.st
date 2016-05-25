Class {
	#name : #DAIRCombineSamplerWithTexture,
	#superclass : #DAIRInstruction,
	#instVars : [
		'type'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRCombineSamplerWithTexture class >> sampler: sampler texture: texture [
	^ self new sampler: sampler texture: texture
]

{ #category : #visitor }
DAIRCombineSamplerWithTexture >> accept: visitor [
	^ visitor visitCombineSamplerWithTexture: self
]

{ #category : #printing }
DAIRCombineSamplerWithTexture >> mnemonic [ 
	^ #combineSamplerWithTexture
]

{ #category : #accessing }
DAIRCombineSamplerWithTexture >> sampler [
	^ parameters first
]

{ #category : #construction }
DAIRCombineSamplerWithTexture >> sampler: sampler texture: texture [
	self parameters: { sampler . texture }.
	self assert: sampler type isSamplerType.
	self assert: texture type isTextureType.
	type := DASLSampledTextureType new texture: texture type.
]

{ #category : #accessing }
DAIRCombineSamplerWithTexture >> texture [
	^ parameters second
]

{ #category : #accessing }
DAIRCombineSamplerWithTexture >> type [
	^ type
]
