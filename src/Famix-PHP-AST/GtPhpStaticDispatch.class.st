Class {
	#name : #GtPhpStaticDispatch,
	#superclass : #GtPhpVariableBase,
	#instVars : [
		'className'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpStaticDispatch >> children [
	| result |
	result := super children.
	className ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpStaticDispatch >> className [
	^ className
]
