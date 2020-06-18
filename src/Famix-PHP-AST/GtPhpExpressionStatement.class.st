Class {
	#name : #GtPhpExpressionStatement,
	#superclass : #GtPhpStatement,
	#instVars : [
		'expression'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpExpressionStatement >> children [
	| result |
	result := super children.
	expression ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpExpressionStatement >> expression [
	^ expression
]

{ #category : #testing }
GtPhpExpressionStatement >> isRouteConfigAsssignment [
	^ (self expression isKindOf: GtPhpAssignment) and: [
		(self expression value isKindOf: GtPhpScalar) and: [
			self expression variableBase isKindOf: GtPhpArrayAccess] ]
]
