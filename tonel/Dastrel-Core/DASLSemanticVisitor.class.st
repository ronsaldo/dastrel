Class {
	#name : #DASLSemanticVisitor,
	#superclass : #DASLAstVisitor,
	#instVars : [
		'currentScope'
	],
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #accessing }
DASLSemanticVisitor >> currentScope [
	^ currentScope
]

{ #category : #scope }
DASLSemanticVisitor >> withScope: aScope do: aBlock [
	| oldScope |
	oldScope := currentScope.
	currentScope := aScope.
	aBlock ensure: [ currentScope := oldScope ].
]
