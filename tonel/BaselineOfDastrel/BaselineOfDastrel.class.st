Class {
	#name : #BaselineOfDastrel,
	#superclass : #BaselineOf,
	#category : #BaselineOfDastrel
}

{ #category : #baselines }
BaselineOfDastrel >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
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
			baseline: #'Slovim' with: [
				spec
					repository: 'github://ronsaldo/slovim/tonel' ];
			baseline: #'Phanide' with: [
				spec
					repository: 'github://ronsaldo/phanide/tonel' ].
		spec 
			package: #'Dastrel-BuildTool' with: [
				spec requires: #(#'NeoJSON' #'Dastrel-Core'). ];
			package: #'Dastrel-Core' with: [
				spec requires: #(#'PetitParser' #'Slovim' ). ];
			package: #'Dastrel-IDE' with: [
				spec requires: #(#'Dastrel-Core' ). ];
			package: #'Dastrel-Tests' with: [
				spec requires: #(#'Dastrel-Core' #'Dastrel-BuildTool' ). ];
			package: #'Dastrel-Phanide' with: [
				spec requires: #(#'Dastrel-Core' #'Phanide' ). ] ].

]
