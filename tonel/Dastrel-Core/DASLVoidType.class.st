Class {
	#name : #DASLVoidType,
	#superclass : #DASLOpaqueType,
	#category : #'Dastrel-Core-Type'
}

{ #category : #comparing }
DASLVoidType >> = other [
	^ self class == other class
]

{ #category : #visitor }
DASLVoidType >> accept: aVisitor [
	^ aVisitor visitVoidType: self
]

{ #category : #'as yet unclassified' }
DASLVoidType >> asSlovimType [
	^ SLVMType voidType
]

{ #category : #comparing }
DASLVoidType >> hash [
	^ self class hash
]

{ #category : #testing }
DASLVoidType >> isVoidType [
	^ true
]

{ #category : #printing }
DASLVoidType >> printOn: aStream [
	aStream nextPutAll: 'void'
]
