Trait {
	#name : #TGtPhpArrayAccess,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpArrayAccess >> shortDescriptionOn: aStream [
	self identifier shortDescriptionOn: aStream.
	aStream nextPutAll: '['.
	self index shortDescriptionOn: aStream.
	aStream nextPutAll: ']'.
]
