Extension { #name : #SystemDictionary }

{ #category : #'*Moose-Core-Pharo12Extensions' }
SystemDictionary >> absoluteName [
	"Answer an environment independent (and therefore truely unique) name."

	^ 'Smalltalk'
]

{ #category : #'*Moose-Core-Pharo12Extensions' }
SystemDictionary >> mooseName [
	
	^ #Smalltalk 
]
