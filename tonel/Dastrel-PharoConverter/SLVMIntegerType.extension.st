Extension { #name : #SLVMIntegerType }

{ #category : #'*Dastrel-PharoConverter' }
SLVMIntegerType >> asDastrelConversionTypeWith: converter [
	signed ifTrue: [ 
		size = 1 ifTrue: [ ^ DASLType charType ].
		size = 2 ifTrue: [ ^ DASLType shortType ].
		size = 4 ifTrue: [ ^ DASLType intType ].
		size = 8 ifTrue: [ ^ DASLType longType ].
	] ifFalse: [ 
		size = 1 ifTrue: [ ^ DASLType ucharType ].
		size = 2 ifTrue: [ ^ DASLType ushortType ].
		size = 4 ifTrue: [ ^ DASLType uintType ].
		size = 8 ifTrue: [ ^ DASLType ulongType ].
	].

	self error: 'Unsupported type'
]
