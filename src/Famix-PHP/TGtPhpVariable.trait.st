Trait {
	#name : #TGtPhpVariable,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpVariable >> mooseNameOn: aStream [
	super mooseNameOn: aStream.
	aStream nextPutAll: ' ('.
	self shortDescriptionOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #printing }
TGtPhpVariable >> shortDescriptionOn: aStream [
	(self isDollared= 'true') ifTrue: [ 
		aStream nextPutAll: '$' ].
	aStream
		nextPutAll: self identifier name
]
