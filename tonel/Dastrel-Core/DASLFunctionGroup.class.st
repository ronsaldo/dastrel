Class {
	#name : #DASLFunctionGroup,
	#superclass : #DASLModule,
	#instVars : [
		'alternatives',
		'isOperation'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLFunctionGroup >> accept: aVisitor [
	^ aVisitor visitFunctionGroup: self
]

{ #category : #accessing }
DASLFunctionGroup >> addAllAlternatives: aCollection [
	aCollection do: [ :alternative | self addAlternative: alternative ].
]

{ #category : #accessing }
DASLFunctionGroup >> addAlternative: alternative [
	alternatives add: alternative
]

{ #category : #accessing }
DASLFunctionGroup >> alternatives [
	^ alternatives
]

{ #category : #accessing }
DASLFunctionGroup >> alternatives: anObject [
	alternatives := anObject
]

{ #category : #initialization }
DASLFunctionGroup >> initialize [
	super initialize.
	alternatives := OrderedCollection new.
]

{ #category : #testing }
DASLFunctionGroup >> isFunctionGroup [
	^ true
]

{ #category : #accessing }
DASLFunctionGroup >> isOperation [
	^ isOperation
]

{ #category : #accessing }
DASLFunctionGroup >> isOperation: anObject [
	isOperation := anObject
]

{ #category : #'as yet unclassified' }
DASLFunctionGroup >> referenceType [
	^ DASLFunctionGroupType new functionGroup: self
]
