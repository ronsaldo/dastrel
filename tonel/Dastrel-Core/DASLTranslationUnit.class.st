Class {
	#name : #DASLTranslationUnit,
	#superclass : #DASLAstNode,
	#instVars : [
		'modules'
	],
	#category : #'Dastrel-Core'
}

{ #category : #accessing }
DASLTranslationUnit >> modules [
	^ modules
]

{ #category : #accessing }
DASLTranslationUnit >> modules: anObject [
	modules := anObject
]

{ #category : #'as yet unclassified' }
DASLTranslationUnit >> printOn: aStream [
	modules do: [ :module | module printOn: aStream. aStream lf ]
]
