Class {
	#name : #DASLImportStatement,
	#superclass : #DASLStatement,
	#instVars : [
		'importedUnit',
		'packageName'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLImportStatement >> accept: aVisitor [
	^ aVisitor visitImportStatement: self
]

{ #category : #accessing }
DASLImportStatement >> importedUnit [
	^ importedUnit
]

{ #category : #accessing }
DASLImportStatement >> importedUnit: anObject [
	importedUnit := anObject
]

{ #category : #testing }
DASLImportStatement >> isImportStatement [
	^ true
]

{ #category : #accessing }
DASLImportStatement >> packageName [
	^ packageName
]

{ #category : #accessing }
DASLImportStatement >> packageName: anObject [
	packageName := anObject
]
