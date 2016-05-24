Class {
	#name : #DASLCompilationContext,
	#superclass : #Object,
	#instVars : [
		'translationUnits'
	],
	#category : #'Dastrel-Core-Compiler'
}

{ #category : #'as yet unclassified' }
DASLCompilationContext >> addTranslationUnit: aTranslationUnit [
	translationUnits at: aTranslationUnit fullPath put: aTranslationUnit
]

{ #category : #'as yet unclassified' }
DASLCompilationContext >> importTranslationUnit: fileReference [
	| fullPath |
	fullPath := fileReference asFileReference asAbsolute fullName.
	^ translationUnits at: fullPath ifAbsent: [
		^ DASLCompiler new
			compilationContext: self;
  	 		sourceFromFileNamed: fileReference;
   		 	importCompilation
	] 
	
]

{ #category : #initialization }
DASLCompilationContext >> initialize [
	super initialize.
	translationUnits := Dictionary new.
]
