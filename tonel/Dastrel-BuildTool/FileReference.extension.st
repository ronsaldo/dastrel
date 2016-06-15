Extension { #name : #FileReference }

{ #category : #'*Dastrel-BuildTool' }
FileReference >> asDASLBuildItem [
	^ DASLBuildFileItem new fileReference: self
]
