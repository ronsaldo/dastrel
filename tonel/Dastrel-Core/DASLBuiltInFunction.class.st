Class {
	#name : #DASLBuiltInFunction,
	#superclass : #DASLModule,
	#instVars : [
		'functionType',
		'coercionType',
		'operation',
		'builtInOptions',
		'isMember'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLBuiltInFunction >> accept: aVisitor [
	^ aVisitor visitBuiltInFunction: self
]

{ #category : #accessing }
DASLBuiltInFunction >> builtInOptions [
	^ builtInOptions
]

{ #category : #accessing }
DASLBuiltInFunction >> builtInOptions: anObject [
	builtInOptions := anObject
]

{ #category : #accessing }
DASLBuiltInFunction >> coercionType [
	^ coercionType
]

{ #category : #accessing }
DASLBuiltInFunction >> coercionType: anObject [
	coercionType := anObject
]

{ #category : #accessing }
DASLBuiltInFunction >> functionType [
	^ functionType
]

{ #category : #accessing }
DASLBuiltInFunction >> functionType: anObject [
	functionType := anObject
]

{ #category : #initialization }
DASLBuiltInFunction >> initialize [
	super initialize.
	isMember := false.
]

{ #category : #testing }
DASLBuiltInFunction >> isBuiltInFunction [
	^ true
]

{ #category : #accessing }
DASLBuiltInFunction >> isMember [
	^ isMember
]

{ #category : #accessing }
DASLBuiltInFunction >> isMember: anObject [
	isMember := anObject
]

{ #category : #accessing }
DASLBuiltInFunction >> operation [
	^ operation
]

{ #category : #accessing }
DASLBuiltInFunction >> operation: anObject [
	operation := anObject
]

{ #category : #printing }
DASLBuiltInFunction >> printOn: aStream [
	aStream print: functionType 
]
