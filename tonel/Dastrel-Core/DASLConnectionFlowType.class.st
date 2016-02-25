Class {
	#name : #DASLConnectionFlowType,
	#superclass : #DASLAstNode,
	#instVars : [
		'direction',
		'location'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLConnectionFlowType >> accept: aVisitor [
	^ aVisitor visitConnectionFlowType: self
]

{ #category : #accessing }
DASLConnectionFlowType >> direction [
	^ direction
]

{ #category : #accessing }
DASLConnectionFlowType >> direction: anObject [
	direction := anObject
]

{ #category : #accessing }
DASLConnectionFlowType >> location [
	^ location
]

{ #category : #accessing }
DASLConnectionFlowType >> location: anObject [
	location := anObject
]
