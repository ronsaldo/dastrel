Extension { #name : #SLVMInternalStructure }

{ #category : #'*Dastrel-PharoConverter' }
SLVMInternalStructure class >> asDastrelConversionTypeWith: codeConverter [
	^ codeConverter lowcodeStructureWrapper: self
]
