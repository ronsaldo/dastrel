Class {
	#name : #DASLBuiltInScope,
	#superclass : #DASLexicalScope,
	#category : #'Dastrel-Core-Semantic'
}

{ #category : #adding }
DASLBuiltInScope >> addType: type [
	self at: type name put: type ifPresent: [ 
		self error: 'compiler bug'
	]
]

{ #category : #initialization }
DASLBuiltInScope >> initialize [
	super initialize.
	DASLType builtInTypes values do: [ :type | self addType: type ]
	
]
