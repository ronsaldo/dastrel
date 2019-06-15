Extension { #name : #BlockClosure }

{ #category : #'*Dastrel-PharoConverter' }
BlockClosure >> generateDastrelFunctionWith: codeConverter withName: requiredName argumentTypes: argumentType returnType: returnType [
	^ DASLPharoBlockConverter new
		codeConverter: codeConverter;
		functionName: requiredName;
		convertClosure: self argumentTypes: argumentType returnType: returnType
]
