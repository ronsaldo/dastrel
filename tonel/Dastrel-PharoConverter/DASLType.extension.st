Extension { #name : #DASLType }

{ #category : #'*Dastrel-PharoConverter' }
DASLType >> emitPharoToDastrelConstructionMessage: messageNode receiver: receiverValue with: visitor [
	self error: 'Unsupported construction message'
]
