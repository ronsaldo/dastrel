Extension { #name : #PPToken }

{ #category : #'*Dastrel-Core' }
PPToken >> asDASLCodePosition [
	^ DASLCodePosition new
		collection: collection;
		start: start;
		stop: stop;
		yourself
]
