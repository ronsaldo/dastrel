Class {
	#name : #DASLCodeBlock,
	#superclass : #DASLModule,
	#instVars : [
		'interfaceList',
		'body',
		'codegenValue'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLCodeBlock >> accept: aVisitor [
	^ aVisitor visitCodeBlock: self
]

{ #category : #accessing }
DASLCodeBlock >> body [
	^ body
]

{ #category : #accessing }
DASLCodeBlock >> body: anObject [
	body := anObject
]

{ #category : #accessing }
DASLCodeBlock >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLCodeBlock >> codegenValue: anObject [
	codegenValue := anObject
]

{ #category : #accessing }
DASLCodeBlock >> interfaceList [
	^ interfaceList
]

{ #category : #accessing }
DASLCodeBlock >> interfaceList: anObject [
	interfaceList := anObject ifNil: [ #() ].
]

{ #category : #testing }
DASLCodeBlock >> isCallableBlock [
	^ true
]

{ #category : #testing }
DASLCodeBlock >> isCodeBlock [
	^ true
]

{ #category : #printing }
DASLCodeBlock >> printOn: aStream [
	aStream nextPutAll: '(code-block '.
	aStream nextPutAll: name.
	aStream space.
	self printList: interfaceList on: aStream.
	aStream space.
	self printList: body on: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
DASLCodeBlock >> referenceType [
	^ DASLBlockType new block: self.
]

{ #category : #accessing }
DASLCodeBlock >> type [
	^ DASLBlockType new block: self.
]
