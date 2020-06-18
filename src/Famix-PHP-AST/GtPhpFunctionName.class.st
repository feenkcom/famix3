Class {
	#name : #GtPhpFunctionName,
	#superclass : #GtPhpASTNode,
	#traits : 'TGtPhpFunctionName',
	#classTraits : 'TGtPhpFunctionName classTrait',
	#instVars : [
		'name'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpFunctionName >> children [
	| result |
	result := super children.
	name ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpFunctionName >> name [
	^ name
]
