Class {
	#name : #BaselineOfFame,
	#superclass : #BaselineOf,
	#category : #BaselineOfFame
}

{ #category : #baselines }
BaselineOfFame >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec
			    baseline: 'Mocketry'
			    with: [ spec repository: 'github://dionisiydk/Mocketry:v4.0.x' ].
			spec
				package: 'Fame-Core';
				package: 'Fame-Util';
				package: 'Fame-ImportExport' with: [ spec requires: #('Fame-Core') ];
				package: 'Fame-SmalltalkBinding' with: [ spec requires: #('Fame-Core') ];
				package: 'Fame-CSharpBinding';
				package: 'Fame-Example';
				package: 'Fame-Tests-Core' with: [ spec requires: #('Fame-Core' 'Fame-Example') ].
		].

]
