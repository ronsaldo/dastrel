Class {
	#name : #DAIRBranch,
	#superclass : #DAIRInstruction,
	#instVars : [
		'trueBlock',
		'falseBlock',
		'mergeBlock',
		'continueBlock',
		'unreachableSuccessors'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #construction }
DAIRBranch class >> condition: condition ifTrue: ifTrueBlock ifFalse: ifFalseBlock [
	^ self new condition: condition ifTrue: ifTrueBlock ifFalse: ifFalseBlock
]

{ #category : #visitor }
DAIRBranch >> accept: aVisitor [
	^ aVisitor visitBranch: self
]

{ #category : #accessing }
DAIRBranch >> addUnreachableSuccessors [
	| changed |
	changed := false.
	mergeBlock predecessors ifEmpty: [
		unreachableSuccessors := { mergeBlock }.
		changed := true.
	].

	continueBlock predecessors ifEmpty: [
		unreachableSuccessors := { mergeBlock }.
		changed := true.
	].

	changed ifTrue: [ block computeSuccessors. ]
]

{ #category : #accessing }
DAIRBranch >> condition [
	^ parameters first
]

{ #category : #construction }
DAIRBranch >> condition: condition ifTrue: ifTrueBlock ifFalse: ifFalseBlock [
	self parameters: { condition }.
	trueBlock := ifTrueBlock.
	falseBlock := ifFalseBlock.
]

{ #category : #accessing }
DAIRBranch >> continueBlock [
	^ continueBlock
]

{ #category : #accessing }
DAIRBranch >> continueBlock: anObject [
	continueBlock := anObject
]

{ #category : #accessing }
DAIRBranch >> falseBlock [
	^ falseBlock
]

{ #category : #accessing }
DAIRBranch >> falseBlock: anObject [
	falseBlock := anObject
]

{ #category : #printing }
DAIRBranch >> fullPrintOn: aStream [
	aStream nextPutAll: 'branch '; print: self condition;
		space; nextPutAll: trueBlock name;
		space; nextPutAll: falseBlock name
]

{ #category : #'as yet unclassified' }
DAIRBranch >> initialize [
	super initialize.
	unreachableSuccessors := #()
]

{ #category : #testing }
DAIRBranch >> isBranch [
	^ false
]

{ #category : #testing }
DAIRBranch >> isTerminator [
	^ true
]

{ #category : #accessing }
DAIRBranch >> mergeBlock [
	^ mergeBlock
]

{ #category : #accessing }
DAIRBranch >> mergeBlock: anObject [
	mergeBlock := anObject
]

{ #category : #printing }
DAIRBranch >> mnemonic [
	^ #branch
]

{ #category : #accessing }
DAIRBranch >> successors [
	^ { trueBlock . falseBlock } , unreachableSuccessors
]

{ #category : #accessing }
DAIRBranch >> trueBlock [
	^ trueBlock
]

{ #category : #accessing }
DAIRBranch >> trueBlock: anObject [
	trueBlock := anObject
]

{ #category : #accessing }
DAIRBranch >> type [
	^ DASLType voidType
]
