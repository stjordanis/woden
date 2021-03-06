Class {
	#name : #BaselineOfWodenEngine,
	#superclass : #BaselineOf,
	#category : #BaselineOfWodenEngine
}

{ #category : #baselines }
BaselineOfWodenEngine >> baseline: spec [
    <baseline>
    spec for: #'common' do: [
			spec blessing: #baseline.
			spec postLoadDoIt: #postLoadActions.
			spec 
				baseline: #'NeoJSON' with: [
					spec
					repository: 'github://svenvc/NeoJSON/repository' ].
			spec 
				baseline: #'AbstractGPU' with: [
				spec
					repository: 'github://ronsaldo/abstract-gpu/tonel' ].
			spec 
				baseline: #'AbstractPhysics' with: [
				spec
					repository: 'github://ronsaldo/abstract-physics/tonel' ].
			spec 
				baseline: #'Dastrel' with: [
				spec
					repository: 'github://ronsaldo/dastrel/tonel' ].
			spec 
				baseline: #'BabylonGraphics' with: [
				spec
					repository: 'github://ronsaldo/babylon-graphics/tonel';
                    loads: #(API) ].
			spec 
				baseline: #'CyrusToolkit' with: [
				spec
					repository: 'github://ronsaldo/babylon-graphics/tonel' ].

			spec 
				baseline: #'OpenAL' with: [
				spec
					repository: 'github://ronsaldo/pharo-openal/tonel' ].
			spec 
				baseline: #'WodenMath' with: [
				spec
					repository: 'github://ronsaldo/woden/tonel' ].
		spec package: #'WodenEngine-Core' with: [
				spec requires: #(#'NeoJSON' #'AbstractGPU' #'Dastrel' #'WodenMath')].
		spec package: #'WodenEngine-Babylon' with: [
				spec requires: #('WodenEngine-Core' 'BabylonGraphics' 'CyrusToolkit')].
		spec package: #'WodenEngine-Scene' with: [
				spec requires: #('WodenEngine-Core')].
		spec package: #'WodenEngine-Importers' with: [
				spec requires: #('WodenEngine-Core' #'WodenEngine-Scene')].
		spec package: #'WodenEngine-Samples' with: [
				spec requires: #('WodenEngine-Core' 'WodenEngine-Babylon' 'WodenEngine-Scene' 'WodenEngine-GameSystem' #'WodenEngine-Importers')].
		spec package: #'WodenEngine-Physics' with: [
				spec requires: #('WodenEngine-Core' 'AbstractPhysics')].
		spec package: #'WodenEngine-OpenAL' with: [
				spec requires: #('WodenEngine-Core' 'OpenAL')].
		spec package: #'WodenEngine-GameSystem' with: [
				spec requires: #('WodenEngine-Core' 'WodenEngine-Babylon' 'WodenEngine-Scene' 'WodenEngine-Physics' 'WodenEngine-OpenAL')].
		spec package: #'WodenEngine-LevelEditor' with: [
				spec requires: #('WodenEngine-Core' 'WodenEngine-Babylon' 'WodenEngine-Scene' 'WodenEngine-Physics' 'WodenEngine-OpenAL' 'WodenEngine-GameSystem')].
		spec package: #'WodenEngine-Roassal' with: [
				spec requires: #('WodenEngine-Core' 'WodenEngine-Babylon' 'WodenEngine-Scene' 'WodenEngine-Physics')].

		spec group: 'default' with: #('WodenEngine-Core' 'WodenEngine-Babylon' 'WodenEngine-Samples' 'WodenEngine-GameSystem' 'WodenEngine-LevelEditor' 'WodenEngine-Roassal')
	]

]

{ #category : #baselines }
BaselineOfWodenEngine >> postLoadActions [
	"Reduce the idle time of the image."
	self flag: 'FIXME: This hack should not be required when the idle item is computed according to the next pending delay.'.
	(ProcessorScheduler respondsTo: #idleTime:) ifTrue: [
		ProcessorScheduler idleTime: 250.
	].
	
	"Rebuild the field accessors"
	self flag: 'FIXME: Remove this hack when is not required anymore in Pharo'.
	FFIExternalStructure allSubclassesDo: #rebuildFieldAccessors.

]
