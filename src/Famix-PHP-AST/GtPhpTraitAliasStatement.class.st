Class {
	#name : #GtPhpTraitAliasStatement,
	#superclass : #GtPhpTraitStatement,
	#instVars : [
		'alias'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpTraitAliasStatement >> alias [
	^ alias
]

{ #category : #accessing }
GtPhpTraitAliasStatement >> children [
	| result |
	result := super children.
	alias ifNotNil: [ :x | result add: x ].
	^ result
]
