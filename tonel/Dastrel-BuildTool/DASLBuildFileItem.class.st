Class {
	#name : #DASLBuildFileItem,
	#superclass : #DASLBuildItem,
	#instVars : [
		'fileReference'
	],
	#category : #'Dastrel-BuildTool'
}

{ #category : #testing }
DASLBuildFileItem >> exists [
	^ fileReference exists
]

{ #category : #accessing }
DASLBuildFileItem >> fileReference [
	^ fileReference
]

{ #category : #accessing }
DASLBuildFileItem >> fileReference: aFileReference [
	fileReference := aFileReference.
	name := fileReference basename.
]

{ #category : #accessing }
DASLBuildFileItem >> modificationTime [
	^ fileReference modificationTime
]
