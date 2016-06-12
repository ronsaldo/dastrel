Class {
	#name : #ConfigurationOfDastrel,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfDastrel
}

{ #category : #'development support' }
ConfigurationOfDastrel class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>
]

{ #category : #private }
ConfigurationOfDastrel class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #'ConfigurationOf'
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #'ConfigurationOf' ifAbsent: aBlock ].
]

{ #category : #private }
ConfigurationOfDastrel class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfDastrel class >> ensureMetacelloBaseConfiguration [
  Smalltalk
    at: #'ConfigurationOf'
    ifAbsent: [ 
      | repository version |
      repository := MCHttpRepository
        location: 'http://smalltalkhub.com/mc/dkh/metacello/main'
        user: ''
        password: ''.
      repository
        versionReaderForFileNamed: 'Metacello-Base-dkh.107'
        do: [ :reader | 
          version := reader version.
          version load.
          version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfDastrel class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfDastrel class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfDastrel class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfDastrel class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfDastrel class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfDastrel class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfDastrel >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/ronsaldo/Dastrel/main/'.
		spec project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main/' ].
		spec 
			package: 'Dastrel-Core' with: [
				spec requires: #('PetitParser' ). ];
			package: 'Dastrel-IDE' with: [
				spec requires: #('Dastrel-Core' ). ];
			package: 'Dastrel-SpirV' with: [
				spec requires: #('Dastrel-Core' ). ];
			package: 'Dastrel-Tests' with: [
				spec requires: #('Dastrel-Core' 'Dastrel-SpirV' ). ]. ].

]

{ #category : #baselines }
ConfigurationOfDastrel >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/ronsaldo/Dastrel/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://mc.stfx.eu/Neo' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main/' ].
		spec 
			package: 'Dastrel-Core' with: [
				spec requires: #('PetitParser' 'NeoJSON' ). ];
			package: 'Dastrel-IDE' with: [
				spec requires: #('Dastrel-Core' ). ];
			package: 'Dastrel-SpirV' with: [
				spec requires: #('Dastrel-Core' ). ];
			package: 'Dastrel-Tests' with: [
				spec requires: #('Dastrel-Core' 'Dastrel-SpirV' ). ]. ].

]

{ #category : #baselines }
ConfigurationOfDastrel >> baseline03: spec [
	<version: '0.3-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/ronsaldo/Dastrel/main/'.
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://mc.stfx.eu/Neo' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main/' ];
			project: 'Slovim' with: [
				spec
					className: #ConfigurationOfSlovim;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/ronsaldo/Slovim/main/' ].
		spec 
			package: 'Dastrel-BuildTool' with: [
				spec requires: #('NeoJSON' ). ];
			package: 'Dastrel-Core' with: [
				spec requires: #('PetitParser' 'Slovim' ). ];
			package: 'Dastrel-IDE' with: [
				spec requires: #('Dastrel-Core' ). ];
			package: 'Dastrel-Tests' with: [
				spec requires: #('Dastrel-Core' 'Dastrel-BuildTool' ). ]. ].

]

{ #category : #accessing }
ConfigurationOfDastrel >> customProjectAttributes [
    "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes "

    ^ #()
]

{ #category : #'symbolic versions' }
ConfigurationOfDastrel >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.3-baseline'.

]

{ #category : #accessing }
ConfigurationOfDastrel >> project [
    ^ project
        ifNil: [ 
            "Bootstrap Metacello if it is not already loaded"
            self class ensureMetacello.
            project := MetacelloMCProject new projectAttributes: self customProjectAttributes.	"Create the Metacello project"
            (Smalltalk at: #'MetacelloVersionConstructor') on: self project: project.	"Construct the project"
            project loadType: #'linear'.	"change to #atomic if desired"
            project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfDastrel >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '0.3'.

]

{ #category : #versions }
ConfigurationOfDastrel >> version01: spec [
	<version: '0.1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.1'.
		spec author: 'RonieSalgado'.
		spec timestamp: '5/23/2016 15:59'.
		spec project: 'PetitParser' with: '1.14'.
		spec 
			package: 'Dastrel-Core' with: 'Dastrel-Core-RonieSalgado.29';
			package: 'Dastrel-IDE' with: 'Dastrel-IDE-RonieSalgado.2';
			package: 'Dastrel-SpirV' with: 'Dastrel-SpirV-RonieSalgado.9';
			package: 'Dastrel-Tests' with: 'Dastrel-Tests-RonieSalgado.4'. ].

]

{ #category : #versions }
ConfigurationOfDastrel >> version02: spec [
	<version: '0.2' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2'.
		spec author: 'RonieSalgado'.
		spec timestamp: '5/25/2016 13:09'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: 'Dastrel-Core' with: 'Dastrel-Core-RonieSalgado.34';
			package: 'Dastrel-IDE' with: 'Dastrel-IDE-RonieSalgado.2';
			package: 'Dastrel-SpirV' with: 'Dastrel-SpirV-RonieSalgado.13';
			package: 'Dastrel-Tests' with: 'Dastrel-Tests-RonieSalgado.4'. ].

]

{ #category : #versions }
ConfigurationOfDastrel >> version03: spec [
	<version: '0.3' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.3'.
		spec author: 'RonieSalgado'.
		spec timestamp: '5/26/2016 14:02'.
		spec 
			project: 'NeoJSON' with: '12';
			project: 'PetitParser' with: '1.14'.
		spec 
			package: 'Dastrel-Core' with: 'Dastrel-Core-RonieSalgado.37';
			package: 'Dastrel-IDE' with: 'Dastrel-IDE-RonieSalgado.2';
			package: 'Dastrel-SpirV' with: 'Dastrel-SpirV-RonieSalgado.14';
			package: 'Dastrel-Tests' with: 'Dastrel-Tests-RonieSalgado.4'. ].

]
