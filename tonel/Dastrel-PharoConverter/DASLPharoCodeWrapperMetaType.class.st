Class {
	#name : #DASLPharoCodeWrapperMetaType,
	#superclass : #DASLPharoCodeClassWrapperStructureType,
	#category : #'Dastrel-PharoConverter-WrapperTypes'
}

{ #category : #'as yet unclassified' }
DASLPharoCodeWrapperMetaType >> emitPharoToDastrelMessage: messageNode receiver: receiverValue with: visitor [
	| compiledMethod arguments returnType constructedType actuallyConstructedType selector position components argValue |
	compiledMethod := wrappedClass lookupSelector: messageNode selector.
	compiledMethod ifNil: [
		self error: 'Cannot convert message send {1}.' format: { messageNode selector printString } at: messageNode
	].

	selector := messageNode selector.
	((compiledMethod hasPragmaNamed: #constructor) or: [#(new basicNew) includes: selector]) ifTrue: [ 
		constructedType := wrappedClass instanceSide asDastrelConversionTypeWith: visitor codeConverter.
		actuallyConstructedType := visitor codeConverter evaluateTypeSpecification: constructedType name.
		^ actuallyConstructedType emitPharoToDastrelConstructionMessage: messageNode receiver: receiverValue with: visitor
	].

	^ super emitMessage: messageNode with: visitor
]
