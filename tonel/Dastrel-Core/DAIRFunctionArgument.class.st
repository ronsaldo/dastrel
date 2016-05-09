Class {
	#name : #DAIRFunctionArgument,
	#superclass : #DAIRValue,
	#instVars : [
		'type',
		'index',
		'name'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #accessing }
DAIRFunctionArgument >> index [
	^ index
]

{ #category : #accessing }
DAIRFunctionArgument >> index: anObject [
	index := anObject
]

{ #category : #accessing }
DAIRFunctionArgument >> name [
	^ name
]

{ #category : #accessing }
DAIRFunctionArgument >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DAIRFunctionArgument >> type [
	^ type
]

{ #category : #accessing }
DAIRFunctionArgument >> type: anObject [
	type := anObject
]
