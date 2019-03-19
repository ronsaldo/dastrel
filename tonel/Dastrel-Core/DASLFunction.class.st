Class {
	#name : #DASLFunction,
	#superclass : #DASLModule,
	#instVars : [
		'pragmas',
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
DASLFunction >> codegenValue [
	^ prototype codegenValue
]

{ #category : #accessing }
DASLFunction >> codegenValue: anObject [
	^ prototype codegenValue: anObject
]

{ #category : #accessing }
DASLFunction >> functionType [
	^ prototype functionType
]

{ #category : #testing }
DASLFunction >> hasPragmaNamed: selector [
	^ pragmas anySatisfy: [ :p | p selector = selector ]
]

{ #category : #testing }
DASLFunction >> isFunction [
	^ true
]

{ #category : #accessing }
DASLFunction >> mangledName [
	^ prototype mangledName
]

{ #category : #accessing }
DASLFunction >> pragmas [
	^ pragmas
]

{ #category : #accessing }
DASLFunction >> pragmas: anObject [
	pragmas := anObject
]

{ #category : #accessing }
DASLFunction >> prototype [
	^ prototype
]

{ #category : #accessing }
DASLFunction >> prototype: anObject [
	prototype := anObject
]
