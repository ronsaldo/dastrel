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
			baseline: 'NeoJSON' with: [
				spec
				repository: 'github://svenvc/NeoJSON/repository' ];
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main/' ];
			baseline: #'Slovim' with: [
				spec
					repository: 'github://ronsaldo/slovim/tonel';
					loads: #(#'ShaderCompilation' #'Runtime') ];
			baseline: #'Phanide' with: [
				spec
					repository: 'github://ronsaldo/phanide/tonel' ].
		spec 
			package: #'Dastrel-BuildTool' with: [
				spec requires: #(#'NeoJSON' #'Dastrel-Core'). ];
			package: #'Dastrel-Core' with: [
				spec requires: #(#'PetitParser' #'Slovim' ). ];
			package: #'Dastrel-PharoConverter' with: [
				spec requires: #(#'Dastrel-Core' ). ];
			package: #'Dastrel-Tests' with: [
				spec requires: #(#'Dastrel-Core' #'Dastrel-BuildTool' ). ];
			package: #'Dastrel-Phanide' with: [
				spec requires: #(#'Dastrel-Core' #'Phanide' ). ] ].

]
