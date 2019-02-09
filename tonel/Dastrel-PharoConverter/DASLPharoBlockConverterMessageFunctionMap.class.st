Class {
	#name : #DASLPharoBlockConverterMessageFunctionMap,
	#superclass : #DASLPharoBlockConverterMessageMap,
	#instVars : [
		'functionName'
	],
	#category : #'Dastrel-PharoConverter'
}

{ #category : #accessing }
DASLPharoBlockConverterMessageFunctionMap >> functionName [
	^ functionName
]

{ #category : #accessing }
DASLPharoBlockConverterMessageFunctionMap >> functionName: anObject [
	functionName := anObject
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterMessageFunctionMap >> mapNode: node withArguments: allArguments with: converter [
	^ converter annotateNode: (DASLCallExpression new
		position: (converter convertNodePosition: node);
		reference: (DASLIdentifier new
			position: (converter convertNodePosition: node);
			value: functionName;
			yourself);
		arguments: allArguments;
		yourself)
	withType: (self inferNode: node typeWithArguments: allArguments with: converter )
]
