Class {
	#name : #DASLCodeBlock,
	#superclass : #DASLModule,
	#instVars : [
		'interfaceList',
		'body'
	],
	#category : #'Dastrel-Core'
}

{ #category : #accessing }
DASLCodeBlock >> body [
	^ body
]

{ #category : #accessing }
DASLCodeBlock >> body: anObject [
	body := anObject
]

{ #category : #accessing }
DASLCodeBlock >> interfaceList [
	^ interfaceList
]

{ #category : #accessing }
DASLCodeBlock >> interfaceList: anObject [
	interfaceList := anObject
]
