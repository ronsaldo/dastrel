Class {
	#name : #DASLPharoBlockConverterMessageBinaryOperatorMap,
	#superclass : #DASLPharoBlockConverterMessageMap,
	#instVars : [
		'operatorName'
	],
	#category : #'Dastrel-PharoConverter'
}

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterMessageBinaryOperatorMap >> mapNode: node withArguments: allArguments with: converter [
	^ converter annotateNode: (DASLBinaryOperation new
		position: (converter convertNodePosition: node);
		operation: operatorName;
		left: allArguments first;
		right: allArguments second;
		yourself)
	withType: (self inferNode: node typeWithArguments: allArguments with: converter )
]

{ #category : #accessing }
DASLPharoBlockConverterMessageBinaryOperatorMap >> operatorName [
	^ operatorName
]

{ #category : #accessing }
DASLPharoBlockConverterMessageBinaryOperatorMap >> operatorName: anObject [
	operatorName := anObject
]
