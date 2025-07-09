Extension { #name : #Package }

{ #category : #'*Moose-SmalltalkImporter' }
Package >> regularClassExtensions [

	^ self extensionMethods reject: [:aCompiledMethod | aCompiledMethod methodClass isTrait]
]

{ #category : #'*Moose-SmalltalkImporter' }
Package >> regularClasses [

	^ self definedClasses reject: [:each | each isTrait]
]
