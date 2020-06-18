Class {
	#name : #GtPhpFieldAccess,
	#superclass : #GtPhpDispatch,
	#traits : 'TGtPhpFieldAccess',
	#classTraits : 'TGtPhpFieldAccess classTrait',
	#instVars : [
		'property'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpFieldAccess >> children [
	| result |
	result := super children.
	property ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpFieldAccess >> property [
	^ property
]
