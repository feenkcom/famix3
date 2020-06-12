Extension { #name : #MooseModel }

{ #category : #'*Famix-PHP' }
MooseModel >> allPhpPrograms [
	<navigation: 'All PHP programs'>
	^ self allWithType: GtPhpProgram
]

{ #category : #'*Famix-PHP' }
MooseModel >> phpImportAsts [
	self rootFolder allFiles do: [ :file |
		file extension = 'ast' ifTrue: [
			| program |
			program := GtPhpProgram new importFromFile: file.
			program fileReference: file withoutExtension, 'php'.
			self add: program ] ]
]
