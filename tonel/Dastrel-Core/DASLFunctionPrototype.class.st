Class {
	#name : #DASLFunctionPrototype,
	#superclass : #DASLModule,
	#instVars : [
		'arguments',
		'returnType',
		'functionType'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLFunctionPrototype >> accept: aVisitor [
	^ aVisitor visitFunctionPrototype: self
]

{ #category : #accessing }
DASLFunctionPrototype >> arguments [
	^ arguments
]

{ #category : #accessing }
DASLFunctionPrototype >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
DASLFunctionPrototype >> functionType [
	^ functionType
]

{ #category : #accessing }
DASLFunctionPrototype >> functionType: anObject [
	functionType := anObject
]

{ #category : #accessing }
DASLFunctionPrototype >> returnType [
	^ returnType
]

{ #category : #accessing }
DASLFunctionPrototype >> returnType: anObject [
	returnType := anObject
]
