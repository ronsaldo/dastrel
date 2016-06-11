Class {
	#name : #DASLStructureLikeBlock,
	#superclass : #DASLModule,
	#instVars : [
		'interfaceList',
		'body'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #accessing }
DASLStructureLikeBlock >> body [
	^ body
]

{ #category : #accessing }
DASLStructureLikeBlock >> body: anArray [
	body := anArray.
	body doWithIndex: [ :field :index | field fieldIndex: index - 1]
]

{ #category : #accessing }
DASLStructureLikeBlock >> interfaceList [
	^ interfaceList
]

{ #category : #accessing }
DASLStructureLikeBlock >> interfaceList: anObject [
	interfaceList := anObject ifNil: [ #() ].
]

{ #category : #accessing }
DASLStructureLikeBlock >> referenceType [
	^ DASLBlockType new block: self.
]
