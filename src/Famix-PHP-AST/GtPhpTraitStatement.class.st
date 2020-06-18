Class {
	#name : #GtPhpTraitStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'exp'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpTraitStatement >> children [
	| result |
	result := super children.
	exp ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpTraitStatement >> exp [
	^ exp
]
