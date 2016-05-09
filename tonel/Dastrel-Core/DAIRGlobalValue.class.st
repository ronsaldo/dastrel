Class {
	#name : #DAIRGlobalValue,
	#superclass : #DAIRConstant,
	#instVars : [
		'name'
	],
	#category : #'Dastrel-Core-SSA'
}

{ #category : #accessing }
DAIRGlobalValue >> name [
	^ name
]

{ #category : #accessing }
DAIRGlobalValue >> name: anObject [
	name := anObject
]
