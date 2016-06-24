Class {
	#name : #DASLBuildTool,
	#superclass : #Object,
	#instVars : [
		'compiler'
	],
	#classVars : [
		'StageSuffixMap',
		'TargetList'
	],
	#category : #'Dastrel-BuildTool'
}

{ #category : #'as yet unclassified' }
DASLBuildTool class >> build: jsonFileName [
	^ self new build: jsonFileName
]

{ #category : #'as yet unclassified' }
DASLBuildTool class >> rebuild: jsonFileName [
	^ self new rebuild: jsonFileName
]

{ #category : #building }
DASLBuildTool >> build: jsonFileName [
	| project |
	project := DASLBuildProject loadFromFileNamed: jsonFileName.
	self buildElements: ((DASLBuildDependencySorter sortProject: project) select: #needsBuilding)
]

{ #category : #'as yet unclassified' }
DASLBuildTool >> buildElements: aCollectionOfElements [
	| percentage |
	aCollectionOfElements doWithIndex: [ :el :index |
		percentage := index - 1 / (aCollectionOfElements size - 1) asFloat.
		el buildReportPercentage: percentage
	].


]

{ #category : #'as yet unclassified' }
DASLBuildTool >> rebuild: jsonFileName [
	| project |
	project := DASLBuildProject loadFromFileNamed: jsonFileName.
	self buildElements: (DASLBuildDependencySorter sortProject: project)
]
