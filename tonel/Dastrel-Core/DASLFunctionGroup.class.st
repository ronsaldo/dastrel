Class {
	#name : #DASLFunctionGroup,
	#superclass : #DASLModule,
	#instVars : [
		'alternatives',
		'isOperation',
		'isMember'
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

{ #category : #accessing }
DASLFunctionGroup >> codegenValue [
	^ name
]

{ #category : #initialization }
DASLFunctionGroup >> initialize [
	super initialize.
	alternatives := OrderedCollection new.
	isMember := false.
]

{ #category : #testing }
DASLFunctionGroup >> isFunctionGroup [
	^ true
]

{ #category : #accessing }
DASLFunctionGroup >> isMember [
	^ isMember
]

{ #category : #accessing }
DASLFunctionGroup >> isMember: anObject [
	isMember := anObject
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
