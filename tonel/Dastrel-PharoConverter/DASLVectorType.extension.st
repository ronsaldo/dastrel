Extension { #name : #DASLVectorType }

{ #category : #'*Dastrel-PharoConverter' }
DASLVectorType >> emitPharoToDastrelConstructionMessage: messageNode receiver: receiverValue with: visitor [
	| position components selector argValue nextComponentIndex argumentComponentCount firstComponentIndex |
	position := visitor convertNodePosition: messageNode.
	selector := messageNode selector.
	components := {}.
	nextComponentIndex := 1.
	
	(selector splitOn: ':') allButLast doWithIndex: [ :argName :index |
		argValue := visitor visitNode: (messageNode arguments at: index).

		argumentComponentCount := argName size.
		firstComponentIndex := 'xyzw' indexOf: argName first.
		nextComponentIndex to: firstComponentIndex - 1 do: [ :i |
			components := components , { 0.0 asDastrelLiteralAt: position inContext: visitor for: nil   }
		].
		components := components , { argValue }.
		nextComponentIndex := ('xyzw' indexOf: argName last) + 1.
	].
		
	^ visitor annotateNode: (DASLCallExpression new
		position: position;
		reference: self asDastrelTypeNode;
		arguments: components;
		yourself) withType: self

]

{ #category : #'*Dastrel-PharoConverter' }
DASLVectorType >> emitPharoToDastrelMessage: messageNode receiver: receiverValue with: visitor [
	| memberAccess canBeSwizzle |
	messageNode selector size <= 4 ifTrue: [ 
		canBeSwizzle := true.
		messageNode selector do: [ :c |
			('xyzw' includes: c) ifFalse: [ canBeSwizzle := false ]
		].
		canBeSwizzle ifTrue: [
			memberAccess := DASLMemberAccessExpression new
				reference: receiverValue;
				memberName: messageNode selector.
			^ visitor annotateNode: memberAccess withType: baseType
		].
	].
	

	^ super emitPharoToDastrelMessage: messageNode receiver: receiverValue with: visitor
]
