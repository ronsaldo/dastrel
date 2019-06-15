Extension { #name : #Point }

{ #category : #'*Dastrel-PharoConverter' }
Point >> asDastrelLiteralAt: aPosition inContext: context for: variable [
	| type |
	type := self inferDastrelTypeIn: context for: nil.
	^ DASLCallExpression new
		position: aPosition;
		reference: (type asDastrelTypeNode
			position: aPosition);
		arguments: {
			x asDastrelLiteralAt: aPosition inContext: context for: variable.
			y asDastrelLiteralAt: aPosition inContext: context for: variable.
		};
		yourself
]

{ #category : #'*Dastrel-PharoConverter' }
Point >> inferDastrelTypeIn: context for: variable [
	(x isInteger and: [ y isInteger ]) ifTrue: [ 
		^ context codeConverter evaluateTypeSpecification: #int2
	].
	(x isFloat and: [ y isFloat ]) ifTrue: [ 
		^ context codeConverter evaluateTypeSpecification: #float2
	].

	^ super inferDastrelTypeIn: context for: variable
]
