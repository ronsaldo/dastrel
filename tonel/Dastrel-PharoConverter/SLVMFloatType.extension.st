Extension { #name : #SLVMFloatType }

{ #category : #'*Dastrel-PharoConverter' }
SLVMFloatType >> asDastrelConversionTypeWith: converter [
	size = 4 ifTrue: [ ^ DASLType floatType ].
	size = 8 ifTrue: [ ^ DASLType doubleType ].
	self error: 'Unsupported type'
]
