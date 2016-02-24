Class {
	#name : #DASLFunction,
	#superclass : #DASLModule,
	#instVars : [
		'prototype',
		'body'
	],
	#category : #'Dastrel-Core'
}

{ #category : #accessing }
DASLFunction >> body [
	^ body
]

{ #category : #accessing }
DASLFunction >> body: anObject [
	body := anObject
]

{ #category : #accessing }
DASLFunction >> prototype [
	^ prototype
]

{ #category : #accessing }
DASLFunction >> prototype: anObject [
	prototype := anObject
]
