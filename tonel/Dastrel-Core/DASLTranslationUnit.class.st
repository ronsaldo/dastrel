Class {
	#name : #DASLTranslationUnit,
	#superclass : #DASLAstNode,
	#instVars : [
		'modules',
		'package',
		'fullPath',
		'importedUnits'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #visitor }
DASLTranslationUnit >> accept: aVisitor [
	^ aVisitor visitTranslationUnit: self
]

{ #category : #accessing }
DASLTranslationUnit >> addImportedUnit: aTranslationUnit [
	importedUnits add: aTranslationUnit
]

{ #category : #accessing }
DASLTranslationUnit >> fullPath [
	^ fullPath
]

{ #category : #accessing }
DASLTranslationUnit >> fullPath: anObject [
	fullPath := anObject
]

{ #category : #accessing }
DASLTranslationUnit >> importedUnits [
	^ importedUnits
]

{ #category : #initialization }
DASLTranslationUnit >> initialize [
	super initialize.
	importedUnits := SLVMOrderedInsertionSet new.
]

{ #category : #accessing }
DASLTranslationUnit >> modules [
	^ modules
]

{ #category : #accessing }
DASLTranslationUnit >> modules: anObject [
	modules := anObject
]

{ #category : #accessing }
DASLTranslationUnit >> package [
	^ package
]

{ #category : #accessing }
DASLTranslationUnit >> package: anObject [
	package := anObject
]

{ #category : #printing }
DASLTranslationUnit >> printOn: aStream [
	modules do: [ :module | module printOn: aStream. aStream lf ]
]
