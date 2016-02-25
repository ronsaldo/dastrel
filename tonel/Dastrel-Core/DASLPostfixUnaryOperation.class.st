Class {
	#name : #DASLPostfixUnaryOperation,
	#superclass : #DASLUnaryOperation,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLPostfixUnaryOperation >> accept: aVisitor [
	^ aVisitor visitPostfixUnaryOperation: self
]

{ #category : #printing }
DASLPostfixUnaryOperation >> printOn: aStream [
	aStream nextPutAll: '(postfix '.
	operation printOn: aStream.
	aStream space.
	operand printOn: aStream.
	aStream nextPut: $).
]
