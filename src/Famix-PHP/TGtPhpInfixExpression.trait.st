Trait {
	#name : #TGtPhpInfixExpression,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #importing }
TGtPhpInfixExpression >> importFrom: anElement [
	| leftElement rightElement |
	anElement attributes keysAndValuesDo: [ :key :value |
		self attributeAt: key put: value ].
	
	leftElement := anElement elements first.
	rightElement := anElement elements second.
	
	left := ((self newAstNodeNamed: leftElement localName) importFrom: leftElement).
	right := ((self newAstNodeNamed: rightElement localName) importFrom: rightElement).
	
	self children do: [ :each | each parentNode: self ].
]
