"
A DASVGraphBlockTest is a test class for testing the behavior of DASVGraphBlock
"
Class {
	#name : #DASVGraphBlockTest,
	#superclass : #TestCase,
	#category : #'Dastrel-Tests'
}

{ #category : #'as yet unclassified' }
DASVGraphBlockTest >> testAddNode [
	| block node|
	block := DASVGraphBlock new.
	node := DASVGraphNode new.
	block addNode: node.
	self assert: block numberOfNodes equals: 1.
	self assert: block numberOfConnections equals: 0.
	
]

{ #category : #'as yet unclassified' }
DASVGraphBlockTest >> testNew [
	| block |
	block := DASVGraphBlock new.
	self assert: block numberOfNodes equals: 0.
	self assert: block numberOfConnections equals: 0.
	
]
