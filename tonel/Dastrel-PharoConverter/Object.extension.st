Extension { #name : #Object }

{ #category : #'*Dastrel-PharoConverter' }
Object >> inferDastrelTypeIn: context for: variable [
	^ context error: 'Cannot infer type for captured object {1}.' format: {self printString} at: variable position
]
