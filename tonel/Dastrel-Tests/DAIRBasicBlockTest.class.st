"
A DAIRBasicBlockTest is a test class for testing the behavior of DAIRBasicBlock
"
Class {
	#name : #DAIRBasicBlockTest,
	#superclass : #TestCase,
	#category : #'Dastrel-Tests'
}

{ #category : #'as yet unclassified' }
DAIRBasicBlockTest >> testAddInstruction [
	| basicBlock instruction |
	basicBlock := DAIRBasicBlock new.
	instruction := DAIRInstruction new.
	basicBlock add: instruction.
	self deny: basicBlock isEmpty.
	self assert: basicBlock numberOfInstructions = 1.
	self assert: basicBlock instructions first == instruction.
	self assert: basicBlock predecessors isEmpty.
	self assert: basicBlock successors isEmpty.
	self assert: instruction block = basicBlock
	
]

{ #category : #'as yet unclassified' }
DAIRBasicBlockTest >> testNew [
	| basicBlock |
	basicBlock := DAIRBasicBlock new.
	self assert: basicBlock isEmpty.
	self assert: basicBlock numberOfInstructions = 0.
	self assert: basicBlock predecessors isEmpty.
	self assert: basicBlock successors isEmpty.
	
]
