Class {
	#name : #DASLGraphBlock,
	#superclass : #DASLModule,
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLGraphBlock >> accept: aVisitor [
	^ aVisitor visitGraphBlock: self
]

{ #category : #testing }
DASLGraphBlock >> isGraphBlock [
	^ true
]

{ #category : #accessing }
DASLGraphBlock >> type [
	^ DASLBlockType new block: self.
]
