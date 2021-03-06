Class {
	#name : #DASLPharoCodeLowcodeStructureType,
	#superclass : #DASLPharoCodeClassWrapperStructureType,
	#category : #'Dastrel-PharoConverter-WrapperTypes'
}

{ #category : #'as yet unclassified' }
DASLPharoCodeLowcodeStructureType >> emitPharoToDastrelMessage: messageNode receiver: receiverValue with: visitor [
	| compiledMethod memberName memberAccess slvmType dastrelType |
	compiledMethod := wrappedClass lookupSelector: messageNode selector.
	compiledMethod ifNil: [
		self error: 'Cannot convert message send {1}.' format: { messageNode selector printString } at: messageNode
	].

	(compiledMethod hasPragmaNamed: #accessor) ifTrue: [
		memberName := messageNode arguments size = 1 ifTrue: [
			messageNode selector allButLast asSymbol
		] ifFalse: [ messageNode selector ].
	
		slvmType := (wrappedClass classLayout slotScope atName: memberName) type.
		dastrelType := slvmType asDastrelConversionTypeWith: visitor codeConverter.
	
		memberAccess := DASLMemberAccessExpression new
			reference: receiverValue;
			memberName: memberName asSymbol.
		visitor annotateNode: memberAccess withType: dastrelType.

		^ messageNode arguments size = 1 ifTrue: [
			DASLAssignmentExpression new
				operation: #=;
				reference: memberAccess;
				value: (visitor visitNode: messageNode arguments first)
		] ifFalse: [
			memberAccess 
		]
	].

	^ super emitPharoToDastrelMessage: messageNode receiver: receiverValue with: visitor
]
