Trait {
	#name : #TGtPhpIdentifier,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #printing }
TGtPhpIdentifier >> mooseNameOn: stream [
	super mooseNameOn: stream.
	stream 
		nextPutAll: ' (';
		nextPutAll: self name;
		nextPutAll: ')'
]
