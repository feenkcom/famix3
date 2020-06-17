Class {
	#name : #GtPhpStaticFieldAccess,
	#superclass : #GtPhpStaticDispatch,
	#instVars : [
		'field'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpStaticFieldAccess >> children [
	| result |
	result := super children.
	field ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpStaticFieldAccess >> field [
	^ field
]
