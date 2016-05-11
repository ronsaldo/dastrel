Class {
	#name : #DASLStructureBlock,
	#superclass : #DASLModule,
	#instVars : [
		'interfaceList',
		'body'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLStructureBlock >> body [
	^ body
]

{ #category : #accessing }
DASLStructureBlock >> body: anArray [
	body := anArray.
	body doWithIndex: [ :field :index | field fieldIndex: index - 1]
]

{ #category : #accessing }
DASLStructureBlock >> interfaceList [
	^ interfaceList
]

{ #category : #accessing }
DASLStructureBlock >> interfaceList: anObject [
	interfaceList := anObject ifNil: [ #() ].
]

{ #category : #accessing }
DASLStructureBlock >> referenceType [
	^ DASLBlockType new block: self.
]
