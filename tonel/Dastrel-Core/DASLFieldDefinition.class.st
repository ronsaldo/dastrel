Class {
	#name : #DASLFieldDefinition,
	#superclass : #DASLAstNode,
	#instVars : [
		'flow',
		'type',
		'name'
	],
	#category : #'Dastrel-Core'
}

{ #category : #accessing }
DASLFieldDefinition >> flow [
	^ flow
]

{ #category : #accessing }
DASLFieldDefinition >> flow: anObject [
	flow := anObject
]

{ #category : #accessing }
DASLFieldDefinition >> name [
	^ name
]

{ #category : #accessing }
DASLFieldDefinition >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DASLFieldDefinition >> type [
	^ type
]

{ #category : #accessing }
DASLFieldDefinition >> type: anObject [
	type := anObject
]
