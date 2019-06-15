Class {
	#name : #DASLPharoCodeClassWrapperStructureType,
	#superclass : #DASLPharoCodeWrapperStructureType,
	#instVars : [
		'wrappedClass'
	],
	#category : #'Dastrel-PharoConverter-WrapperTypes'
}

{ #category : #'as yet unclassified' }
DASLPharoCodeClassWrapperStructureType >> emitMessage: messageNode receiver: receiverValue with: visitor [
	| compiledMethod arguments returnType |
	compiledMethod := wrappedClass lookupSelector: messageNode selector.
	compiledMethod ifNil: [
		self error: 'Cannot convert message send {1}.' format: { messageNode selector printString } at: messageNode
	].

	(compiledMethod pragmaAt: #dastrelShaderFunction:returnType:) ifNotNil: [ :pragma |
		arguments := messageNode arguments collect: [ :arg | visitor visitNode: arg ].
		returnType := visitor codeConverter evaluateTypeSpecification: pragma arguments second.
		
		^ visitor annotateNode: (DASLCallExpression new
			reference: (DASLIdentifier new value: pragma arguments first);
			arguments: arguments;
			yourself
		) withType: returnType
	].

	^ super emitMessage: messageNode with: visitor
]

{ #category : #accessing }
DASLPharoCodeClassWrapperStructureType >> wrappedClass [
	^ wrappedClass
]

{ #category : #accessing }
DASLPharoCodeClassWrapperStructureType >> wrappedClass: anObject [
	wrappedClass := anObject
]
