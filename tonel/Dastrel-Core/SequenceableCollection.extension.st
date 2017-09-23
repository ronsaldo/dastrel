Extension { #name : #SequenceableCollection }

{ #category : #'*Dastrel-Core' }
SequenceableCollection >> asDastrelCollectionWithContext [
	^ DASLCollectionWithContext new collection: self
]
