Class {
	#name : #DASLParser,
	#superclass : #DASLGrammar,
	#category : #'Dastrel-Core'
}

{ #category : #grammar }
DASLParser >> blockVariable [
	^ super blockVariable ==> [:var | DASLFieldDefinition new
			position: var second position;
			flow: var first;
			type: var second;
			name: var third value;
			yourself]
]

{ #category : #tokens }
DASLParser >> float [
	^ super float ==> [ :token | DASLFloat token: token ]
]

{ #category : #tokens }
DASLParser >> identifier [
	^ super identifier ==> [ :token | DASLIdentifier token: token ]
]

{ #category : #tokens }
DASLParser >> integer [
	^ super integer ==> [ :token | DASLInteger token: token ]
]

{ #category : #grammar }
DASLParser >> interface [
	^ super interface ==> [ :iface | DASLInterface new
			setPositionFromToken: iface first;
			name: iface second value;
			interfaceList: iface third;
			body: iface fifth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> interfaceImplementations [
	^ super interfaceImplementations ==> [ :implements | { implements second } , (implements third collect: #second) ]
]

{ #category : #grammar }
DASLParser >> semantic [
	^ super semantic ==> [ :block | DASLSemanticBlock new
			setPositionFromToken: block first;
			name: block second value;
			interfaceList: block third;
			body: block fifth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> uniform [
	^ super uniform ==> [ :block | DASLUniformBlock new
			setPositionFromToken: block first;
			name: block second value;
			interfaceList: block third;
			body: block fifth;
			yourself ]
]

{ #category : #grammar }
DASLParser >> varFlowDirection [
	^ super varFlowDirection ==> [ :flow | DASLConnectionFlowType new
			setPositionFromToken: flow first;
			direction: flow first inputValue asSymbol;
			location: flow second;
			yourself ]
]

{ #category : #grammar }
DASLParser >> varFlowLocation [
	^ super varFlowLocation ==> [ :location | location second value ]
]
