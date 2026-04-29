Extension { #name : #SystemEnvironment }

{ #category : #'*Moose-Core' }
SystemEnvironment >> absoluteName [
	"Answer an environment independent (and therefore truely unique) name."

	^ 'Smalltalk'
]

{ #category : #'*Moose-Core' }
SystemEnvironment >> mooseName [
	
	^ #Smalltalk 
]
