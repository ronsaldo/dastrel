Extension { #name : #SLVMStructureType }

{ #category : #'*Dastrel-PharoConverter' }
SLVMStructureType >> asDastrelConversionTypeWith: codeConverter [
	behavior ifNotNil: [
		^ behavior asDastrelConversionTypeWith: codeConverter
	].

	self halt
]
