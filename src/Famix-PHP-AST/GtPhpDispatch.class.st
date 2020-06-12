Class {
	#name : #GtPhpDispatch,
	#superclass : #GtPhpVariableBase,
	#instVars : [
		'dispatcher'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpDispatch >> children [
	| result |
	result := super children.
	dispatcher ifNotNil: [ :x | result add: x ].
	^ result
]
