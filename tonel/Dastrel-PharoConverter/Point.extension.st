Extension { #name : #Point }

{ #category : #'*Dastrel-PharoConverter' }
Point >> asDastrelLiteralAt: aPosition inContext: context for: variable [
	| type |
	type := self inferDastrelTypeIn: context for: nil.
	^ DASLCallExpression new
		position: aPosition;
		reference: (DASLIdentifier new
			position: aPosition;
			value: type;
			yourself);
		arguments: {
			x asDastrelLiteralAt: aPosition inContext: context for: variable.
			y asDastrelLiteralAt: aPosition inContext: context for: variable.
		};
		yourself
]

{ #category : #'*Dastrel-PharoConverter' }
Point >> inferDastrelTypeIn: context for: variable [
	(x isInteger and: [ y isInteger ]) ifTrue: [ 
		^ #int2
	].
	(x isFloat and: [ y isFloat ]) ifTrue: [ 
		^ #float2
	].

	^ super inferDastrelTypeIn: context for: variable
]
