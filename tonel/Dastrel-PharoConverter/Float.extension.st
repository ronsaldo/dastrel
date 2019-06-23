Extension { #name : #Float }

{ #category : #'*Dastrel-PharoConverter' }
Float >> asDastrelLiteralAt: aPosition inContext: context for: variable [
	^ DASLFloat new
		position: aPosition;
		value: self;
		type: DASLType floatType;
		yourself
]

{ #category : #'*Dastrel-PharoConverter' }
Float >> generateDastrelFunctionWith: codeConverter withName: requiredName argumentTypes: argumentType returnType: returnType [
	| source |
	self assert: returnType = #float.
	source := ByteString streamContents: [:out |
		out nextPutAll: 'function '; nextPutAll: requiredName; nextPutAll: '('.
		argumentType doWithIndex: [ :arg :index |
			index > 1 ifTrue: [ out nextPutAll: ', ' ].
			out nextPut: $a; print: index; nextPutAll: ': '; nextPutAll: arg
		].
	
		out nextPutAll: ') -> '; nextPutAll: returnType;
			nextPutAll: '{ return '; print: self; nextPutAll: 'f; }'
	].

	^ codeConverter parseFunctionDefinition: source
]

{ #category : #'*Dastrel-PharoConverter' }
Float >> inferDastrelTypeIn: context for: variable [
	^ context codeConverter evaluateTypeSpecification: #float
]
