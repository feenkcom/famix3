Trait {
	#name : #TGtPhpVariable,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpVariable >> shortDescriptionOn: aStream [
	(self isDollared= 'true') ifTrue: [ 
		aStream nextPutAll: '$' ].
	aStream
		nextPutAll: self identifier name
]
