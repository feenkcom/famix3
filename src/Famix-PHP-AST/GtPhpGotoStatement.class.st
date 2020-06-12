Class {
	#name : #GtPhpGotoStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'label'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpGotoStatement >> children [
	| result |
	result := super children.
	label ifNotNil: [ :x | result add: x ].
	^ result
]
