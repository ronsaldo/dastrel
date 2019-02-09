Extension { #name : #RBProgramNode }

{ #category : #'*Dastrel-PharoConverter' }
RBProgramNode >> asDASLCodePositionWithCollection: aCollection [
	^ DASLCodePosition new
		collection: aCollection;
		start: self start;
		stop: self stop;
		yourself
]
