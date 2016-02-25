Class {
	#name : #DASLTranslationUnit,
	#superclass : #DASLAstNode,
	#instVars : [
		'modules'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLTranslationUnit >> accept: aVisitor [
	^ aVisitor visitTranslationUnit: self
]

{ #category : #accessing }
DASLTranslationUnit >> modules [
	^ modules
]

{ #category : #accessing }
DASLTranslationUnit >> modules: anObject [
	modules := anObject
]

{ #category : #printing }
DASLTranslationUnit >> printOn: aStream [
	modules do: [ :module | module printOn: aStream. aStream lf ]
]
