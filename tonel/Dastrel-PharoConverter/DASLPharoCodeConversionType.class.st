Class {
	#name : #DASLPharoCodeConversionType,
	#superclass : #Object,
	#category : #'Dastrel-PharoConverter-WrapperTypes'
}

{ #category : #converting }
DASLPharoCodeConversionType >> asDastrelTypeNode [
	self subclassResponsibility
]

{ #category : #converting }
DASLPharoCodeConversionType >> asFunctionReferenceType [
	^ DASLPharoCodeReferenceType new baseType: self
]

{ #category : #testing }
DASLPharoCodeConversionType >> isPrimitiveType [
	^ false
]

{ #category : #testing }
DASLPharoCodeConversionType >> isReferenceType [
	^ false
]

{ #category : #testing }
DASLPharoCodeConversionType >> isType [
	^ true
]

{ #category : #testing }
DASLPharoCodeConversionType >> isVectorType [
	^ false
]
