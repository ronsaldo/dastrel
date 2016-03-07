Class {
	#name : #DASLFunction,
	#superclass : #DASLModule,
	#instVars : [
		'prototype',
		'body'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLFunction >> accept: aVisitor [
	^ aVisitor visitFunction: self
]

{ #category : #accessing }
DASLFunction >> body [
	^ body
]

{ #category : #accessing }
DASLFunction >> body: anObject [
	body := anObject
]

{ #category : #accessing }
DASLFunction >> functionType [
	^ prototype functionType
]

{ #category : #accessing }
DASLFunction >> prototype [
	^ prototype
]

{ #category : #accessing }
DASLFunction >> prototype: anObject [
	prototype := anObject
]
