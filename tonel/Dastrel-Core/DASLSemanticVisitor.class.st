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

{ #category : #resolving }
DASLSemanticVisitor >> resolveType: typeExpression [
	"Visit the type expression"
	typeExpression accept: self.
	
	(typeExpression type isType and: [typeExpression type isTypeWrapper]) ifFalse: [ 
		self error: 'expected a type' at: typeExpression.
	].

	^ typeExpression type wrapped
]

{ #category : #resolving }
DASLSemanticVisitor >> resolveTypeOf: node [
	node type: (self resolveType: node type)
]

{ #category : #scope }
DASLSemanticVisitor >> withScope: aScope do: aBlock [
	| oldScope |
	oldScope := currentScope.
	currentScope := aScope.
	aBlock ensure: [ currentScope := oldScope ].
]
