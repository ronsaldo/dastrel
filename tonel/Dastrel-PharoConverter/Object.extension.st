Extension { #name : #Object }

{ #category : #'*Dastrel-PharoConverter' }
Object class >> asDastrelConversionTypeWith: codeConverter [
	self error: 'Unsupported dastrel conversion as dastrel type.'
]

{ #category : #'*Dastrel-PharoConverter' }
Object class >> asDastrelLiteralAt: aPosition inContext: context for: variable [
	| instanceType literalNode |
	instanceType := self asDastrelConversionTypeWith: context codeConverter.
	^ instanceType asDastrelTypeNode position: aPosition
]

{ #category : #'*Dastrel-PharoConverter' }
Object >> inferDastrelTypeIn: context for: variable [
	^ context error: 'Cannot infer type for captured object {1}.' format: {self printString} at: variable position
]
