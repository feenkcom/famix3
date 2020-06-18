Class {
	#name : #GtPhpGotoLabel,
	#superclass : #GtPhpStatement,
	#instVars : [
		'name'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpGotoLabel >> children [
	| result |
	result := super children.
	name ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpGotoLabel >> name [
	^ name
]
