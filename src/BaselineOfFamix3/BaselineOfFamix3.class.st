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
				spec repository: 'github://feenkcom/famix3:v0.8.15/src' ].
		spec
			baseline: 'CollectionExtensions' with: [
				spec repository: 'github://pharo-contributions/CollectionExtensions:7d61095afdead8d6949b7f0d5412964b200837a5/src' ].

		spec package: 'Moose-Query'.
		spec package: 'Moose-Core' with: [
			spec requires: #('Fame' #'Moose-Query') ].
		spec package: 'Famix-Core' with: [
			spec requires: #('Moose-Core') ].
		spec package: 'Famix-Extensions' with: [
			spec requires: #('Famix-Core') ].
		spec package: 'Famix-Smalltalk' with: [
			spec requires: #('Famix-Core' 'Famix-Extensions') ].
		spec package: 'Famix-Implementation' with: [
			spec requires: #('Famix-Core') ].
		spec package: 'Famix-Java' with: [
			spec requires: #('Famix-Core') ].
		spec package: 'Famix-CSharp' with: [
			spec requires: #('Famix-Core') ].
		spec package: 'Famix-PHP' with: [
			spec requires: #('Famix-Core') ].
		spec package: 'Famix-PHP-Symfony' with: [
			spec requires: #('Famix-PHP' 'Famix-Extensions') ].
		spec package: 'Famix-PHP-AST' with: [
			spec requires: #('Famix-PHP') ].
		spec package: 'Famix-VB' with: [
			spec requires: #('Famix-Core') ].
		spec package: 'Famix-SourceAnchor' with: [
			spec requires: #('Famix-Core') ].
		spec package: 'Famix-File' with: [
			spec requires: #('Famix-Core' 'Famix-SourceAnchor') ].
		spec package: 'Moose-GenericImporter' with: [
			spec requires: #('Famix-File' 'Moose-Core') ].
		spec package: 'Famix-C' with: [
			spec requires: #('Famix-Core' 'Famix-File') ].
		spec package: 'Famix-CPP' with: [
			spec requires: #('Famix-Core' 'Famix-File' 'Famix-C' 'Famix-Extensions') ].
		spec package: 'Famix-Tests-C' with: [
			spec requires: #('Famix-C') ].
		spec package: 'Moose-Query-Extensions' with: [
			spec requires: #('Famix-Core') ].
		spec package: 'Moose-SmalltalkImporter' with: [
			spec requires: #('Famix-Smalltalk' 'Famix-SourceAnchor' 'Moose-GenericImporter') ].
		spec package: 'Famix-Tests-Core'.
		spec package: 'Moose-TestResources-Reference-Core'.
		spec package: 'Moose-TestResources-Reference-PackageOne' with: [
			spec requires: #('Moose-TestResources-Reference-Core') ].
		spec package: 'Moose-TestResources-LAN'.
		spec package: 'Moose-Tests-Core' with: [
			spec requires: #('Moose-Core' 'Moose-TestResources-Reference-Core' 'Moose-TestResources-LAN') ].
		spec package: 'Moose-Tests-SmalltalkImporter-LAN' with: [
			spec requires: #('Moose-Tests-Core' 'Moose-TestResources-LAN') ].
		spec package: 'Moose-Tests-SmalltalkImporter-Core' with: [
			spec requires: #('Moose-Tests-SmalltalkImporter-LAN' 'Moose-TestResources-Reference-PackageOne') ].
		spec package: 'Moose-TestResources-Reference-PackageTwo' with: [
			spec requires: #('Moose-TestResources-Reference-PackageOne' 'Moose-Tests-SmalltalkImporter-Core') ].
		spec package: 'Famix-Tests-Java' with: [
			spec requires: #('Moose-Tests-Core') ].
		spec package: 'Moose-TestResources-LCOM'.
		spec package: 'Famix-Tests-Extensions' with: [
			spec requires: #('Moose-TestResources-LCOM') ].
		spec package: 'Moose-Query-Test' with: [
			spec requires: #('Famix-Core' #'Moose-Query-Extensions') ].
	]
]
