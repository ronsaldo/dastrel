Class {
	#name : #DASLPharoCodeSysmelStructureType,
	#superclass : #DASLPharoCodeClassWrapperStructureType,
	#category : #'Dastrel-PharoConverter-WrapperTypes'
}

{ #category : #'as yet unclassified' }
DASLPharoCodeSysmelStructureType >> emitPharoToDastrelMessage: messageNode receiver: receiverValue with: visitor [
	| selector compiledMethod |
	selector := messageNode selector.
	compiledMethod := wrappedClass lookupSelector: selector.
	compiledMethod ifNil: [
		self error: 'Cannot convert message send {1}.' format: { selector printString } at: messageNode
	].

	(self isSelector: selector anAccessorOf: wrappedClass) ifTrue: [
		| memberName sysmelType dastrelType memberAccess |
		memberName := messageNode arguments size = 1 ifTrue: [
			messageNode selector allButLast asSymbol
		] ifFalse: [ messageNode selector ].

		sysmelType := (wrappedClass classLayout slotScope resolveSlot: memberName) type.
		dastrelType := sysmelType asDastrelConversionTypeWith: visitor codeConverter.
	
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

{ #category : #'as yet unclassified' }
DASLPharoCodeSysmelStructureType >> isSelector: selector anAccessorOf: targetClass [
	| numArgs memberName |
	numArgs := selector numArgs.
	numArgs > 1 ifTrue: [ ^ false ].
	memberName := selector.
	numArgs = 1 ifTrue: [ memberName := selector allButLast asSymbol ].
	
	^ wrappedClass classLayout slotScope
		resolveSlot: memberName ifFound: [ true ] ifNone: [false]
]
