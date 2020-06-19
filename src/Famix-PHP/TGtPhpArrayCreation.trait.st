Trait {
	#name : #TGtPhpArrayCreation,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpArrayCreation >> shortDescriptionOn: aStream [
	self elements 
		ifEmpty: [ aStream nextPutAll: 'array()' ]
		ifNotEmpty: [ aStream nextPutAll: 'array(...)' ]
]
