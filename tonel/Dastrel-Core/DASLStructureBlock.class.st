Class {
	#name : #DASLStructureBlock,
	#superclass : #DASLModule,
	#instVars : [
		'interfaceList',
		'body'
	],
	#category : #'Dastrel-Core'
}

{ #category : #accessing }
DASLStructureBlock >> body [
	^ body
]

{ #category : #accessing }
DASLStructureBlock >> body: anObject [
	body := anObject
]

{ #category : #accessing }
DASLStructureBlock >> interfaceList [
	^ interfaceList
]

{ #category : #accessing }
DASLStructureBlock >> interfaceList: anObject [
	interfaceList := anObject ifNil: [ #() ].
]
