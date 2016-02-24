Class {
	#name : #DASLFunctionPrototype,
	#superclass : #DASLModule,
	#instVars : [
		'arguments',
		'returnType'
	],
	#category : #'Dastrel-Core'
}

{ #category : #accessing }
DASLFunctionPrototype >> arguments [
	^ arguments
]

{ #category : #accessing }
DASLFunctionPrototype >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
DASLFunctionPrototype >> returnType [
	^ returnType
]

{ #category : #accessing }
DASLFunctionPrototype >> returnType: anObject [
	returnType := anObject
]
