Class {
	#name : #DASLPharoBlockConverterMessageFunctionMap,
	#superclass : #DASLPharoBlockConverterMessageMap,
	#instVars : [
		'functionName',
		'swizzleIndices'
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
		arguments: (self swizzleArguments: allArguments);
		yourself)
	withType: (self inferNode: node typeWithArguments: allArguments with: converter )
]

{ #category : #'as yet unclassified' }
DASLPharoBlockConverterMessageFunctionMap >> swizzleArguments: arguments [
	swizzleIndices ifNotNil: [ 
		^ swizzleIndices collect: [ :index | arguments at: index ]
	].

	^ arguments
]

{ #category : #accessing }
DASLPharoBlockConverterMessageFunctionMap >> swizzleIndices [
	^ swizzleIndices
]

{ #category : #accessing }
DASLPharoBlockConverterMessageFunctionMap >> swizzleIndices: anObject [
	swizzleIndices := anObject
]
