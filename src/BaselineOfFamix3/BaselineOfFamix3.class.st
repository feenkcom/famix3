Class {
	#name : #BaselineOfFamix3,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamix3
}

{ #category : #baseline }
BaselineOfFamix3 >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'Fame' with: [
				spec repository: 'github://feenkcom/famix3:main/src' ];
			baseline: 'CollectionExtensions' with: [
				spec repository: 'github://pharo-contributions/CollectionExtensions/src' ].
		spec 
			package: #'Moose-Query';
			package: 'Moose-Core' with: [
				spec requires: #('Fame' #'Moose-Query' ). ];
			package: 'Famix-Core' with: [
				spec requires: #('Moose-Core' ). ];
			package: 'Famix-Extensions' with: [
				spec requires: #('Famix-Core' ). ];
			package: 'Famix-Smalltalk' with: [
				spec requires: #('Famix-Core' 'Famix-Extensions' ). ];
			package: 'Famix-Implementation' with: [
				spec requires: #('Famix-Core' ). ];
			package: 'Famix-Java' with: [
				spec requires: #('Famix-Core' ). ];
			package: 'Famix-CSharp' with: [
				spec requires: #('Famix-Core' ). ];
			package: 'Famix-PHP' with: [
				spec requires: #('Famix-Core' ). ];
			package: 'Famix-PHP-Symfony' with: [
				spec requires: #('Famix-PHP' 'Famix-Extensions' ). ];
			package: 'Famix-PHP-AST' with: [
				spec requires: #('Famix-PHP' ). ];
			package: 'Famix-VB' with: [
				spec requires: #('Famix-Core' ). ];
			package: 'Famix-SourceAnchor' with: [
				spec requires: #('Famix-Core' ). ];
			package: 'Famix-File' with: [
				spec requires: #('Famix-Core' 'Famix-SourceAnchor' ). ];
			package: 'Moose-GenericImporter' with: [
				spec requires: #('Famix-File' 'Moose-Core' ). ];
			package: 'Famix-C' with: [
				spec requires: #('Famix-Core' 'Famix-File' ). ];
			package: 'Famix-CPP' with: [
				spec requires: #('Famix-Core' 'Famix-File' 'Famix-C' 'Famix-Extensions' ). ];
			package: 'Famix-Tests-C' with: [
				spec requires: #('Famix-C' ). ];
			package: #'Moose-Query-Extensions' with: [
				spec requires: #('Famix-Core' ). ];
			package: 'Moose-SmalltalkImporter' with: [
				spec requires: #('Famix-Smalltalk' 'Famix-SourceAnchor' 'Moose-GenericImporter' ). ];
			package: 'Famix-Tests-Core';
			package: 'Moose-TestResources-Reference-Core';
			package: 'Moose-TestResources-Reference-PackageOne' with: [
				spec requires: #('Moose-TestResources-Reference-Core' ). ];
			package: 'Moose-TestResources-LAN';
			package: 'Moose-Tests-Core' with: [
				spec requires: #('Moose-Core' 'Moose-TestResources-Reference-Core' 'Moose-TestResources-LAN' ). ];
			package: 'Moose-Tests-SmalltalkImporter-LAN' with: [
				spec requires: #('Moose-Tests-Core' 'Moose-TestResources-LAN' ). ];
			package: 'Moose-Tests-SmalltalkImporter-Core' with: [
				spec requires: #('Moose-Tests-SmalltalkImporter-LAN' 'Moose-TestResources-Reference-PackageOne' ). ];
			package: 'Moose-TestResources-Reference-PackageTwo' with: [
				spec requires: #('Moose-TestResources-Reference-PackageOne' 'Moose-Tests-SmalltalkImporter-Core' ). ];
			package: 'Famix-Tests-Java' with: [
				spec requires: #('Moose-Tests-Core' ). ];
			package: 'Moose-TestResources-LCOM';
			package: 'Famix-Tests-Extensions' with: [
				spec requires: #('Moose-TestResources-LCOM' ). ];
			package: #'Moose-Query-Test' with: [
				spec requires: #('Famix-Core' #'Moose-Query-Extensions' ). ]. ].

]
