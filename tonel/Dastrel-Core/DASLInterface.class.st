Class {
	#name : #DASLInterface,
	#superclass : #DASLModule,
	#instVars : [
		'interfaceList',
		'body'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLInterface >> accept: aVisitor [
	^ aVisitor visitInterface: self
]

{ #category : #accessing }
DASLInterface >> body [
	^ body
]

{ #category : #accessing }
DASLInterface >> body: anObject [
	body := anObject
]

{ #category : #accessing }
DASLInterface >> interfaceList [
	^ interfaceList
]

{ #category : #accessing }
DASLInterface >> interfaceList: anObject [
	interfaceList := anObject ifNil: [ #() ].
]
