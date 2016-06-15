"
A DASVGraphNodeTest is a test class for testing the behavior of DASVGraphNode
"
Class {
	#name : #DASVGraphNodeTest,
	#superclass : #TestCase,
	#category : #'Dastrel-Tests'
}

{ #category : #'as yet unclassified' }
DASVGraphNodeTest >> testCenter [
	| node |
	node := DASVGraphNode new.
	self assert: node center equals: node position + (node extent / 2).
	node center: 6@6.
	self assert: node center equals: 6@6.
]

{ #category : #'as yet unclassified' }
DASVGraphNodeTest >> testNew [
	| node |
	node := DASVGraphNode new.
	self assert: node numberOfInputs equals: 0.
	self assert: node numberOfOutputs equals: 0.
	self assert: node title isString.
	self assert: node position isPoint.
	self assert: node extent isPoint.
	self assert: node bounds isRectangle.
	
]
