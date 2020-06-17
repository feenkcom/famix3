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

{ #category : #accessing }
GtPhpProgram >> commentMapper [
	^ commentMapper
]

{ #category : #accessing }
GtPhpProgram >> comments [
	^ comments
]

{ #category : #initialization }
GtPhpProgram >> initialize [
	super initialize.
	comments := OrderedCollection new.
	statements := OrderedCollection new.
	useStatements := OrderedCollection new.
	namespaceDeclarations := OrderedCollection new.

]

{ #category : #accessing }
GtPhpProgram >> lineEndTable [
	^ lineEndTable
]

{ #category : #accessing }
GtPhpProgram >> namespaceDeclarations [
	^ namespaceDeclarations
]

{ #category : #accessing }
GtPhpProgram >> sourceModule [
	^ sourceModule
]

{ #category : #accessing }
GtPhpProgram >> statements [
	^ statements
]

{ #category : #accessing }
GtPhpProgram >> useStatements [
	^ useStatements
]
