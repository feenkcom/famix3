Extension { #name : #FAMIXNamedEntity }

{ #category : #'*Famix-PHP-Symfony' }
FAMIXNamedEntity >> gtPhpAnnotationNamed: aString [
	^ self annotationInstances 
		detect: [ :annotationInstance | annotationInstance annotationType name = aString ]
		ifNone: [ nil ]
]

{ #category : #'*Famix-PHP-Symfony' }
FAMIXNamedEntity >> gtPhpName [
	^ self mooseName copyReplaceAll: '::' with: '\'
]
