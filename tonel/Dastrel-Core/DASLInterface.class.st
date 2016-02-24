Class {
	#name : #DASLInterface,
	#superclass : #DASLModule,
	#instVars : [
		'interfaceList',
		'body'
	],
	#category : #'Dastrel-Core'
}

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
	interfaceList := anObject
]
