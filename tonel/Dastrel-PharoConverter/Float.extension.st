Extension { #name : #Float }

{ #category : #'*Dastrel-PharoConverter' }
Float >> asDastrelLiteralAt: aPosition inContext: context for: variable [
	^ DASLFloat new
		position: aPosition;
		value: self;
		type: DASLType floatType;
		yourself
]

{ #category : #'*Dastrel-PharoConverter' }
Float >> inferDastrelTypeIn: context for: variable [
	^ #float
]
