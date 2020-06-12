Class {
	#name : #GtPhpProgram,
	#superclass : #GtPhpASTNode,
	#instVars : [
		'comments',
		'statements',
		'useStatements',
		'sourceModule',
		'lineEndTable',
		'namespaceDeclarations',
		'commentMapper'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpProgram >> children [
	| result |
	result := super children.
	result addAll: comments.
	result addAll: statements.
	result addAll: useStatements.
	result addAll: namespaceDeclarations.
	commentMapper ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #initialization }
GtPhpProgram >> initialize [
	super initialize.
	comments := OrderedCollection new.
	statements := OrderedCollection new.
	useStatements := OrderedCollection new.
	namespaceDeclarations := OrderedCollection new.

]
