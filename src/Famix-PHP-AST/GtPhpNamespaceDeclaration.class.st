Class {
	#name : #GtPhpNamespaceDeclaration,
	#superclass : #GtPhpStatement,
	#instVars : [
		'block',
		'namespaceName'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpNamespaceDeclaration >> body [
	^ block
]

{ #category : #accessing }
GtPhpNamespaceDeclaration >> children [
	| result |
	result := super children.
	namespaceName ifNotNil: [ :x | result add: x ].
	block ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpNamespaceDeclaration >> name [
	^ namespaceName
]
