Class {
	#name : #GtPhpSwitchStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'expression',
		'body'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpSwitchStatement >> body [
	^ body
]

{ #category : #accessing }
GtPhpSwitchStatement >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	body ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpSwitchStatement >> expression [
	^ expression
]
