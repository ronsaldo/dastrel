Class {
	#name : #DASLBuildShader,
	#superclass : #DASLBuildItem,
	#instVars : [
		'targetLanguages',
		'stages'
	],
	#category : #'Dastrel-BuildTool'
}

{ #category : #adding }
DASLBuildShader >> addStages: newStages [
	stages addAll: newStages.
	self addDependencies: newStages.
]

{ #category : #'as yet unclassified' }
DASLBuildShader >> createStagesMetaData [
	| result |
	result := OrderedDictionary new.
	stages do: [ :stage |
		result at: stage name put: stage createStageMetaData
	].
	^ result
]

{ #category : #initialization }
DASLBuildShader >> initialize [
	super initialize.
	stages := OrderedCollection new.
]
