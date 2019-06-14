Class {
	#name : #DASLPharoCodeConverter,
	#superclass : #Object,
	#category : #'Dastrel-PharoConverter'
}

{ #category : #'as yet unclassified' }
DASLPharoCodeConverter >> convertFunction: function name: requiredName argumentTypes: argumentType returnType: returnType [
	^ DASLPharoBlockConverter new
		functionName: requiredName;
		convertClosure: function argumentTypes: argumentType returnType: returnType
]
