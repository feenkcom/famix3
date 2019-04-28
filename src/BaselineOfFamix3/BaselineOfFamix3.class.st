Class {
	#name : #BaselineOfFamix3,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamix3
}

{ #category : #baselines }
BaselineOfFamix3 >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec 
				baseline: 'Fame' with: [
					spec repository: 'github://feenkcom/famix3/src' ].
			spec 
				package: 'Famix-C' with: [
					spec requires: #('Famix-Core' 'Famix-File' ). ];
				package: 'Famix-Core' with: [
					spec requires: #('Moose-Core' ). ];
				package: 'Famix-CPlusPlus' with: [
					spec requires: #('Famix-Core' ). ];
				package: 'Famix-Extensions' with: [
					spec requires: #('Famix-Core' ). ];
				package: 'Famix-File' with: [
					spec requires: #('Famix-Core' 'Famix-SourceAnchor' ). ];
				package: 'Famix-Implementation' with: [
					spec requires: #('Famix-Core' ). ];
				package: 'Famix-Java' with: [
					spec requires: #('Famix-Core' ). ];
				package: 'Famix-CSharp' with: [
					spec requires: #('Famix-Core' ). ];
				package: 'Famix-Smalltalk' with: [
					spec requires: #('Famix-Core' 'Famix-Extensions'). ];
				package: 'Famix-SourceAnchor' with: [
					spec requires: #('Famix-Core' ). ];
				package: 'Famix-Tests-C' with: [
					spec requires: #('Famix-C' ). ];
				package: 'Moose-Core' with: [
					spec requires: #('Fame' 'Moose-Query' ). ];
				package: 'Moose-GenericImporter' with: [
					spec requires: #('Famix-File' 'Moose-Core' ). ];
				package: #'Moose-Query';
				package: #'Moose-Query-Extensions' with: [
					spec requires: #('Famix-Core'). ];
				package: 'Moose-SmalltalkImporter' with: [
					spec requires: #('Famix-Smalltalk' 'Famix-SourceAnchor' 'Moose-GenericImporter' ). ];
				
				package: 'Moose-Tests-Core' with: [
					spec requires: #('Moose-Core' 'Moose-TestResources-Reference-Core' 'Moose-TestResources-LAN') ];
				package: 'Famix-Tests-Java' with: [
					spec requires: #('Moose-Tests-Core') ];
				package: 'Moose-Tests-SmalltalkImporter-Core' with: [
					spec requires: #('Moose-Tests-SmalltalkImporter-LAN' 'Moose-TestResources-Reference-PackageOne') ];
				package: 'Moose-Tests-SmalltalkImporter-LAN' with: [
					spec requires: #('Moose-Tests-Core' 'Moose-TestResources-LAN') ];
				package: 'Famix-Tests-Core';
				package: 'Famix-Tests-Extensions' with: [
					spec requires: #('Moose-TestResources-LCOM') ];
				package: 'Moose-TestResources-Reference-Core';
				package: 'Moose-TestResources-Reference-PackageOne' with: [
					spec requires: #('Moose-TestResources-Reference-Core') ];
				package: 'Moose-TestResources-Reference-PackageTwo' with: [
					spec requires: #('Moose-TestResources-Reference-PackageOne' 'Moose-Tests-SmalltalkImporter-Core') ];
				package: 'Moose-TestResources-LAN';
				package: 'Moose-TestResources-LCOM';
				package: #'Moose-Query-Test' with: [
					spec requires: #(#'Famix-Core' #'Moose-Query-Extensions') ].		].

]