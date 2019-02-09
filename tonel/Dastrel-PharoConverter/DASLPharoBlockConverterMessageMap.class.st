Class {
	#name : #DASLPharoBlockConverterMessageMap,
	#superclass : #Object,
	#instVars : [
		'selector',
		'returnType'
	],
	#category : #'Dastrel-PharoConverter'
}

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterMessageMap >> inferNode: node typeWithArguments: arguments with: converter [
	returnType isBlock ifTrue: [ 
		^ returnType cull: (arguments collect: [:arg | converter annotatedNodeType: arg])
			cull: node
			cull: converter
	].

	^ returnType
]

{ #category : #accessing }
DASLPharoBlockConverterMessageMap >> returnType [
	^ returnType
]

{ #category : #accessing }
DASLPharoBlockConverterMessageMap >> returnType: anObject [
	returnType := anObject
]

{ #category : #accessing }
DASLPharoBlockConverterMessageMap >> selector [
	^ selector
]

{ #category : #accessing }
DASLPharoBlockConverterMessageMap >> selector: anObject [
	selector := anObject
]
