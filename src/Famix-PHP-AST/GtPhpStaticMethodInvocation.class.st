Class {
	#name : #GtPhpStaticMethodInvocation,
	#superclass : #GtPhpStaticDispatch,
	#instVars : [
		'method'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpStaticMethodInvocation >> children [
	| result |
	result := super children.
	method ifNotNil: [ :x | result add: x ].
	^ result
]
