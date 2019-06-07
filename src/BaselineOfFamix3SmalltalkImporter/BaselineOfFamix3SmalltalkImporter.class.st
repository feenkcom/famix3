Class {
	#name : #BaselineOfFamix3SmalltalkImporter,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamix3SmalltalkImporter
}

{ #category : #baseline }
BaselineOfFamix3SmalltalkImporter >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'Famix3' with: [
				spec repository: 'github://feenkcom/famix3:v0.6.2/src' ].
		spec 
			package: 'Moose-SmalltalkImporter' with: [
				spec requires: #('Famix3' ). ];
			package: #'Moose-Query-Test';
			package: #'Moose-TestResources-KGB-P4FullInteracted';
			package: #'Moose-TestResources-KGB-P6InteractedReferee';
			package: #'Moose-TestResources-KGB-P5FullReferee' with: [
				spec requires: #(#'Moose-TestResources-KGB-P6InteractedReferee' ). ];
			package: #'Moose-TestResources-KGB-P1FullReferencer' with: [
				spec requires: #(#'Moose-TestResources-KGB-P5FullReferee' #'Moose-TestResources-KGB-P6InteractedReferee' ). ];
			package: #'Moose-TestResources-KGB-P7ReferencerReferee' with: [
				spec requires: #(#'Moose-TestResources-KGB-P5FullReferee' #'Moose-TestResources-KGB-P6InteractedReferee' ). ];
			package: #'Moose-TestResources-KGB-P2InteractedReferencerReferee' with: [
				spec requires: #(#'Moose-TestResources-KGB-P5FullReferee' #'Moose-TestResources-KGB-P7ReferencerReferee' ). ];
			package: #'Moose-TestResources-KGB-P3InteractedReferencer' with: [
				spec requires: #(#'Moose-TestResources-KGB-P2InteractedReferencerReferee' #'Moose-TestResources-KGB-P5FullReferee' ). ];
			package: #'Moose-TestResources-KGB-P10InteractedReferee';
			package: #'Moose-TestResources-KGB-P11FullReferee';
			package: #'Moose-TestResources-KGB-P9FullReferencer' with: [
				spec requires: #(#'Moose-TestResources-KGB-P10InteractedReferee' #'Moose-TestResources-KGB-P11FullReferee' ). ];
			package: #'Moose-TestResources-KGB-P8FullReferencer' with: [
				spec requires: #(#'Moose-TestResources-KGB-P10InteractedReferee' #'Moose-TestResources-KGB-P11FullReferee' #'Moose-TestResources-KGB-P7ReferencerReferee' ). ];
			package: #'Moose-TestResources-KGB-P12FullReferencer';
			package: #'Moose-TestResources-KGB-P14FullReferee';
			package: #'Moose-TestResources-KGB-P13FullReferencer' with: [
				spec requires: #(#'Moose-TestResources-KGB-P14FullReferee' ). ];
			package: #'Moose-TestResources-KGB-PExtensions' with: [
				spec requires: #(#'Moose-TestResources-KGB-P11FullReferee' #'Moose-TestResources-KGB-P12FullReferencer' ). ];
			package: 'Moose-TestResources-Reference-Core';
			package: 'Moose-TestResources-Reference-PackageOne' with: [
				spec requires: #('Moose-TestResources-Reference-Core' ). ];
			package: 'Moose-TestResources-LAN';
			package: 'Moose-Tests-SmalltalkImporter-LAN' with: [
				spec requires: #('Moose-TestResources-LAN' ). ];
			package: 'Moose-Tests-SmalltalkImporter-Core' with: [
				spec requires: #('Moose-Tests-SmalltalkImporter-LAN' 'Moose-TestResources-Reference-PackageOne' ). ];
			package: 'Moose-TestResources-Reference-PackageTwo' with: [
				spec requires: #('Moose-TestResources-Reference-PackageOne' 'Moose-Tests-SmalltalkImporter-Core' ). ];
			package: 'Moose-TestResources-LCOM';
			package: 'Famix-Tests-Extensions' with: [
				spec requires: #('Moose-TestResources-LCOM' ). ]. ].

]
