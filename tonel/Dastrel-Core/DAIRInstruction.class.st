Class {
	#name : #DAIRInstruction,
	#superclass : #DAIRValue,
	#instVars : [
		'name',
		'block',
		'parameters',
		'instructionReferences'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #adding }
DAIRInstruction >> addInstructionReference: anInstruction [
	instructionReferences add: anInstruction
]

{ #category : #accessing }
DAIRInstruction >> block [
	^ block
]

{ #category : #accessing }
DAIRInstruction >> block: anObject [
	block := anObject
]

{ #category : #printing }
DAIRInstruction >> fullPrintOn: aStream [
	self type isVoidType ifFalse: [
		self printOn: aStream.
		aStream nextPutAll: ' = '.
	].
	aStream nextPutAll: self mnemonic; space.
	parameters doWithIndex: [ :param :index |
		index > 1 ifTrue: [  aStream nextPutAll: ', ' ].
		aStream print: param
	]
]

{ #category : #initialization }
DAIRInstruction >> initialize [
	instructionReferences := Set new.
	parameters := #().
]

{ #category : #accessing }
DAIRInstruction >> instructionReferences [
	^ instructionReferences
]

{ #category : #testing }
DAIRInstruction >> isAlloca [
	^ false
]

{ #category : #testing }
DAIRInstruction >> isBranch [
	^ false
]

{ #category : #testing }
DAIRInstruction >> isInstruction [
	^ true
]

{ #category : #testing }
DAIRInstruction >> isJump [
	^ false
]

{ #category : #testing }
DAIRInstruction >> isLoad [
	^ false
]

{ #category : #testing }
DAIRInstruction >> isStore [
	^ false
]

{ #category : #testing }
DAIRInstruction >> isTerminator [
	^ false
]

{ #category : #testing }
DAIRInstruction >> isUnreachable [
	^ false
]

{ #category : #printing }
DAIRInstruction >> mnemonic [
	self subclassResponsibility
]

{ #category : #accessing }
DAIRInstruction >> name [
	^ name
]

{ #category : #accessing }
DAIRInstruction >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DAIRInstruction >> parameters [
	^ parameters
]

{ #category : #accessing }
DAIRInstruction >> parameters: anArrayOfParameter [
	parameters := anArrayOfParameter.
	parameters do: [ :param | param addInstructionReference: self ]
]

{ #category : #printing }
DAIRInstruction >> printOn: aStream [
	aStream nextPut: $%; nextPutAll: name
]

{ #category : #modifying }
DAIRInstruction >> removeFromBlock [
	block remove: self.
]

{ #category : #accessing }
DAIRInstruction >> successors [
	^ #()
]
