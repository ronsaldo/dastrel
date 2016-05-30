Class {
	#name : #DAIROptimizationPass,
	#superclass : #Object,
	#category : #'Dastrel-Core-SSA'
}

{ #category : #applying }
DAIROptimizationPass class >> passOnFunction: aFunction [
	^ self new passOnFunction: aFunction
]

{ #category : #applying }
DAIROptimizationPass >> passOnFunction: aFunction [
	self subclassResponsibility
]
