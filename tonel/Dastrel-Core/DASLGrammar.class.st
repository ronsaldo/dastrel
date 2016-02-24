Class {
	#name : #DASLGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'identStart',
		'newline',
		'singleLineComment',
		'multiLineComment',
		'ignorable',
		'identifier',
		'integer',
		'floatExponent',
		'floatDotted',
		'floatScientfic',
		'float',
		'number',
		'numberSign',
		'kwInterface',
		'leftCBracket',
		'interfaceBody',
		'rightCBracket',
		'blockVariable',
		'varFlowDirection',
		'type',
		'kwIn',
		'kwOut',
		'leftParent',
		'rightParent',
		'semicolon',
		'primitiveType',
		'kwVoid',
		'kwChar',
		'kwShort',
		'kwInt',
		'kwLong',
		'kwFloat',
		'kwDouble',
		'globalBlocks',
		'interface',
		'kwUniform',
		'kwSemantic',
		'kwImplements',
		'comma',
		'interfaceImplementations',
		'uniform',
		'semantic',
		'semanticBody',
		'uniformBody',
		'varFlowLocation'
	],
	#classVars : [
		'Keywords'
	],
	#category : #'Dastrel-Core'
}

{ #category : #'class initialization' }
DASLGrammar class >> initialize [
	"
	self initialize
	"
	super initialize.
	
	Keywords := #(
		in out
		uniform
		interface semantic implements
		void char short int long float double
		sizeof alignof
	).
]

{ #category : #grammar }
DASLGrammar >> blockVariable [
	^ varFlowDirection optional , type , identifier , semicolon
]

{ #category : #tokens }
DASLGrammar >> comma [
	^ $, asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> float [
	^ floatDotted / floatScientfic
]

{ #category : #tokens }
DASLGrammar >> floatDotted [
	^ (numberSign optional , #digit asParser plus , $. asParser, #digit asParser star , floatExponent optional , #letter asParser star) token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> floatExponent [
	^ ($e asParser / $E asParser) , numberSign optional, #digit asParser plus
]

{ #category : #tokens }
DASLGrammar >> floatScientfic [
	^ (numberSign optional , #digit asParser plus , floatExponent , #letter asParser star) token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> globalBlocks [
	^ interface / uniform / semantic
]

{ #category : #tokens }
DASLGrammar >> identStart [
	^ #letter asParser / $_ asParser
]

{ #category : #tokens }
DASLGrammar >> identifier [
	^ (identStart , (identStart / #digit asParser) star) token trim: ignorable.
]

{ #category : #ignorables }
DASLGrammar >> ignorable [
	^ singleLineComment / #space asParser
]

{ #category : #tokens }
DASLGrammar >> integer [
	^ (numberSign optional , #digit asParser plus , #letter asParser star) token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> interface [
	^ kwInterface , identifier , interfaceImplementations optional , leftCBracket, interfaceBody , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> interfaceBody [
	^ blockVariable star
]

{ #category : #grammar }
DASLGrammar >> interfaceImplementations [
	^ kwImplements , identifier , (comma , identifier) star
]

{ #category : #keywords }
DASLGrammar >> kwChar [
	^ 'char' asParser token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwDouble [
	^ 'double' asParser token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwFloat [
	^ 'float' asParser token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwImplements [
	^ 'implements' asParser token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwIn [
	^ 'in' asParser token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwInt [
	^ 'int' asParser token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwInterface [
	^ 'interface' asParser token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwLong [
	^ 'long' asParser token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwOut [
	^ 'out' asParser token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwSemantic [
	^ 'semantic' asParser token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwShort [
	^ 'short' asParser token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwUniform [
	^ 'uniform' asParser token trim: ignorable
]

{ #category : #keywords }
DASLGrammar >> kwVoid [
	^ 'void' asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> leftBracket [
	^ $[ asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> leftCBracket [
	^ ${ asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> leftParent [
	^ $( asParser token trim: ignorable
]

{ #category : #ignorables }
DASLGrammar >> multiLineComment [
	^ '/*' asParser , '*/' asParser negate star , '*/' asParser
]

{ #category : #ignorables }
DASLGrammar >> newline [
	^ String crlf asParser / String cr asParser / String lf asParser
]

{ #category : #grammar }
DASLGrammar >> number [
	^ float / integer
]

{ #category : #tokens }
DASLGrammar >> numberSign [
	^ $+ asParser / $- asParser
]

{ #category : #grammar }
DASLGrammar >> primitiveType [
	^ kwVoid / kwChar / kwShort / kwInt / kwLong / kwFloat / kwDouble
]

{ #category : #tokens }
DASLGrammar >> rightBracket [
	^ $] asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> rightCBracket [
	^ $} asParser token trim: ignorable
]

{ #category : #tokens }
DASLGrammar >> rightParent [
	^ $) asParser token trim: ignorable
]

{ #category : #grammar }
DASLGrammar >> semantic [
	^ kwSemantic , identifier , interfaceImplementations optional , leftCBracket, semanticBody , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> semanticBody [
	^ blockVariable star
]

{ #category : #tokens }
DASLGrammar >> semicolon [
	^ $; asParser token trim: ignorable
]

{ #category : #ignorables }
DASLGrammar >> singleLineComment [
	^ '//' asParser, newline negate star, newline
]

{ #category : #grammar }
DASLGrammar >> start [
	^ globalBlocks star end
]

{ #category : #grammar }
DASLGrammar >> type [
	^ primitiveType / identifier
]

{ #category : #grammar }
DASLGrammar >> uniform [
	^ kwUniform , identifier , interfaceImplementations optional, leftCBracket, uniformBody , rightCBracket
]

{ #category : #grammar }
DASLGrammar >> uniformBody [
	^ blockVariable star
]

{ #category : #grammar }
DASLGrammar >> varFlowDirection [
	^ kwIn / kwOut , varFlowLocation optional
]

{ #category : #grammar }
DASLGrammar >> varFlowLocation [
	^ leftParent , integer , rightParent
]
