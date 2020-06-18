Class {
	#name : #GtPhpDoStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'condition',
		'body'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpDoStatement >> body [
	^ body
]

{ #category : #accessing }
GtPhpDoStatement >> children [
	| result |
	result := super children.
	condition ifNotNil: [ :x | result add: x ].
	body ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpDoStatement >> condition [
	^ condition
]
