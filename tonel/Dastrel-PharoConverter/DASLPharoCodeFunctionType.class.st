Class {
	#name : #DASLPharoCodeFunctionType,
	#superclass : #DASLPharoCodeConversionType,
	#instVars : [
		'returnType'
	],
	#category : #'Dastrel-PharoConverter-WrapperTypes'
}

{ #category : #'as yet unclassified' }
DASLPharoCodeFunctionType >> emitPharoToDastrelMessage: messageNode receiver: receiverValue with: visitor [
	| selector arguments |
	selector := messageNode selector.
	(#(value value: value:value value:value:value:
		value:value:value:value) includes: selector) ifTrue: [
		arguments := messageNode arguments collect: [ :arg | visitor visitNode: arg ].
		^ visitor annotateNode: (
			DASLCallExpression new
				position: (visitor convertNodePosition: messageNode);
				reference: receiverValue;
				arguments: arguments;
				yourself
			) withType: returnType
	].

	^ super emitPharoToDastrelMessage: messageNode receiver: receiverValue with: visitor
]

{ #category : #accessing }
DASLPharoCodeFunctionType >> returnType [
	^ returnType
]

{ #category : #accessing }
DASLPharoCodeFunctionType >> returnType: anObject [
	returnType := anObject
]
