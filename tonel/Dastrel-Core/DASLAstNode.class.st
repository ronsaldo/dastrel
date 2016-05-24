Class {
	#name : #DASLAstNode,
	#superclass : #DASLObject,
	#instVars : [
		'position'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLAstNode >> accept: aVisitor [
	self subclassResponsibility
]

{ #category : #initialization }
DASLAstNode >> initialize [
	super initialize.
	position := DASLCodePosition  default.
]

{ #category : #testing }
DASLAstNode >> isBuiltInFunction [
	^ false
]

{ #category : #testing }
DASLAstNode >> isCodeBlock [
	^ false
]

{ #category : #testing }
DASLAstNode >> isFunction [
	^ false
]

{ #category : #testing }
DASLAstNode >> isFunctionGroup [
	^ false
]

{ #category : #testing }
DASLAstNode >> isGlobalConnectionBlock [
	^ false
]

{ #category : #testing }
DASLAstNode >> isGraphBlock [
	^ false
]

{ #category : #testing }
DASLAstNode >> isInterface [
	^ false
]

{ #category : #testing }
DASLAstNode >> isLocalDeclaration [
	^ false
]

{ #category : #testing }
DASLAstNode >> isSemanticBlock [
	^ false
]

{ #category : #testing }
DASLAstNode >> isType [
	^ false
]

{ #category : #testing }
DASLAstNode >> isUniformBlock [
	^ false
]

{ #category : #testing }
DASLAstNode >> isUniformGlobal [
	^ false
]

{ #category : #accessing }
DASLAstNode >> position [
	^ position
]

{ #category : #accessing }
DASLAstNode >> position: anObject [
	position := anObject
]

{ #category : #printing }
DASLAstNode >> printList: aList on: aStream [
	| first |
	first := true.
	aStream nextPut: $(.
	aList do: [:el |
		first ifFalse: [ aStream space ].
		el printOn: aStream.
		first := false.
	].
	aStream nextPut: $).
]
