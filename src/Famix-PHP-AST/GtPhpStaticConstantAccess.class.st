Class {
	#name : #GtPhpStaticConstantAccess,
	#superclass : #GtPhpStaticDispatch,
	#instVars : [
		'constant'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpStaticConstantAccess >> children [
	| result |
	result := super children.
	constant ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpStaticConstantAccess >> constant [
	^ constant
]
