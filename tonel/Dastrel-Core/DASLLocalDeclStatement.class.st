Class {
	#name : #DASLLocalDeclStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'flow',
		'name',
		'type',
		'initialValue',
		'codegenValue'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLLocalDeclStatement >> accept: aVisitor [
	^ aVisitor visitLocalDeclaration: self
]

{ #category : #accessing }
DASLLocalDeclStatement >> codegenValue [
	^ codegenValue
]

{ #category : #accessing }
DASLLocalDeclStatement >> codegenValue: anObject [
	codegenValue := anObject
]

{ #category : #accessing }
DASLLocalDeclStatement >> flow [
	^ flow
]

{ #category : #accessing }
DASLLocalDeclStatement >> flow: anObject [
	flow := anObject
]

{ #category : #accessing }
DASLLocalDeclStatement >> initialValue [
	^ initialValue
]

{ #category : #accessing }
DASLLocalDeclStatement >> initialValue: anObject [
	initialValue := anObject
]

{ #category : #testing }
DASLLocalDeclStatement >> isLocalDeclaration [
	^ true
]

{ #category : #accessing }
DASLLocalDeclStatement >> name [
	^ name
]

{ #category : #accessing }
DASLLocalDeclStatement >> name: anObject [
	name := anObject
]

{ #category : #printing }
DASLLocalDeclStatement >> printOn: aStream [
	aStream nextPutAll: '(define '.
	aStream nextPutAll: name.
	initialValue ifNotNil: [ 
		aStream space.
		initialValue printOn: aStream.
	].
	aStream nextPut: $).
	
]

{ #category : #accessing }
DASLLocalDeclStatement >> referenceType [ 
	^ type isReferenceType ifTrue: [ type ] ifFalse: [ DASLReferenceType baseType: type storage: DASLType functionStorage ]
]

{ #category : #accessing }
DASLLocalDeclStatement >> type [
	^ type
]

{ #category : #accessing }
DASLLocalDeclStatement >> type: anObject [
	type := anObject
]
