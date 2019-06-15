Extension { #name : #Integer }

{ #category : #'*Dastrel-PharoConverter' }
Integer >> asDastrelLiteralAt: aPosition inContext: context for: variable [
	^ DASLInteger new
		position: aPosition;
		value: self;
		type: DASLType intType;
		yourself
]

{ #category : #'*Dastrel-PharoConverter' }
Integer >> inferDastrelTypeIn: context for: variable [
	^ context codeConverter evaluateTypeSpecification: #int
]
