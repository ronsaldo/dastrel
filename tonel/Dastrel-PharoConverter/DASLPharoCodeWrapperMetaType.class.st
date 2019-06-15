Class {
	#name : #DASLPharoCodeWrapperMetaType,
	#superclass : #DASLPharoCodeClassWrapperStructureType,
	#category : #'Dastrel-PharoConverter-WrapperTypes'
}

{ #category : #'as yet unclassified' }
DASLPharoCodeWrapperMetaType >> emitMessage: messageNode receiver: receiverValue with: visitor [
	| compiledMethod arguments returnType constructedType actuallyConstructedType selector position components argValue |
	compiledMethod := wrappedClass lookupSelector: messageNode selector.
	compiledMethod ifNil: [
		self error: 'Cannot convert message send {1}.' format: { messageNode selector printString } at: messageNode
	].

	selector := messageNode selector.
	((compiledMethod hasPragmaNamed: #constructor) or: [#(new basicNew) includes: selector]) ifTrue: [ 
		constructedType := wrappedClass instanceSide asDastrelConversionTypeWith: visitor codeConverter.
		actuallyConstructedType := visitor codeConverter evaluateTypeSpecification: constructedType name.
		actuallyConstructedType isVectorType ifTrue: [
			position := visitor convertNodePosition: messageNode.
			components := (1 to: actuallyConstructedType elements) collect: [ :i | 0.0 asDastrelLiteralAt: position inContext: visitor for: nil ].
			(#(new basicNew) includes: selector) ifFalse: [ 
				(selector splitOn: ':') allButLast doWithIndex: [ :argNames :index |
					argValue := visitor visitNode: (messageNode arguments at: index).
					argNames = #x ifTrue: [ components at: 1 put: argValue ].
					argNames = #y ifTrue: [ components at: 2 put: argValue ].
					argNames = #z ifTrue: [ components at: 3 put: argValue ].
					argNames = #w ifTrue: [ components at: 4 put: argValue ].
				].
			].
		
			^ visitor annotateNode: (DASLCallExpression new
				position: position;
				reference: actuallyConstructedType asDastrelTypeNode;
				arguments: components;
				yourself) withType: actuallyConstructedType
		].
		
		self halt.
	].

	^ super emitMessage: messageNode with: visitor
]
