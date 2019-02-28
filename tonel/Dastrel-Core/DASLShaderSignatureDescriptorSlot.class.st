Class {
	#name : #DASLShaderSignatureDescriptorSlot,
	#superclass : #DASLShaderSignatureElement,
	#instVars : [
		'type',
		'arraySize',
		'repetitionCount',
		'set',
		'binding',
		'linearBinding',
		'typeLinearBinding'
	],
	#category : #'Dastrel-Core-AST'
}

{ #category : #arithmetic }
DASLShaderSignatureDescriptorSlot >> + offset [
	^ self copy
		binding: binding + offset
]

{ #category : #visitor }
DASLShaderSignatureDescriptorSlot >> accept: visitor [
	^ visitor visitShaderSignatureDescriptorSlot: self
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> arraySize [
	^ arraySize
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> arraySize: anObject [
	arraySize := anObject
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> binding [
	^ binding
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> binding: anObject [
	binding := anObject
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> linearBinding [
	^ linearBinding
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> linearBinding: anObject [
	linearBinding := anObject
]

{ #category : #'as yet unclassified' }
DASLShaderSignatureDescriptorSlot >> lowerProperty: property for: global on: properties [
	property key ~= #binding ifTrue: [
		self halt
	].

	properties
		at: #binding put: binding;
		at: #set put: set
]

{ #category : #'as yet unclassified' }
DASLShaderSignatureDescriptorSlot >> printOn: aStream [
	aStream nextPutAll: 'bindingSlot: '; print: name;
		space; nextPutAll: 'type: '; print: type;
		space; nextPutAll: 'repetitionCount: '; print: repetitionCount;
		space; nextPutAll: 'set: '; print: set;
		space; nextPutAll: 'binding: '; print: binding;
		space; nextPutAll: 'linearBinding: '; print: linearBinding;
		space; nextPutAll: 'typeLinearBinding: '; print: typeLinearBinding.
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> repetitionCount [
	^ repetitionCount
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> repetitionCount: anObject [
	repetitionCount := anObject
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> set [
	^ set
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> set: anObject [
	set := anObject
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> type [
	^ type
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> type: anObject [
	type := anObject
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> typeLinearBinding [
	^ typeLinearBinding
]

{ #category : #accessing }
DASLShaderSignatureDescriptorSlot >> typeLinearBinding: anObject [
	typeLinearBinding := anObject
]
