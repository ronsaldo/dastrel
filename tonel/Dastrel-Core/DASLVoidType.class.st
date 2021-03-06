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
DASLVoidType >> createSlovimTypeFor: compilationTarget [
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
DASLVoidType >> printMangledOn: aStream [
	aStream nextPut: $v
]

{ #category : #printing }
DASLVoidType >> printOn: aStream [
	aStream nextPutAll: 'void'
]
