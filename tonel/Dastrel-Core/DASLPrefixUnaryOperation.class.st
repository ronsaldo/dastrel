Class {
	#name : #DASLPrefixUnaryOperation,
	#superclass : #DASLUnaryOperation,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLPrefixUnaryOperation >> accept: aVisitor [
	^ aVisitor visitPrefixUnaryOperation: self
]

{ #category : #printing }
DASLPrefixUnaryOperation >> printOn: aStream [
	aStream nextPutAll: '(prefix '.
	operation printOn: aStream.
	aStream space.
	operand printOn: aStream.
	aStream nextPut: $).
]
