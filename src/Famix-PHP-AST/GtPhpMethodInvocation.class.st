Class {
	#name : #GtPhpMethodInvocation,
	#superclass : #GtPhpDispatch,
	#traits : 'TGtPhpMethodInvocation',
	#classTraits : 'TGtPhpMethodInvocation classTrait',
	#instVars : [
		'property'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpMethodInvocation >> children [
	| result |
	result := super children.
	property ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpMethodInvocation >> property [
	^ property
]
