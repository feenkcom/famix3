Class {
	#name : #GtPhpFunctionInvocation,
	#superclass : #GtPhpVariableBase,
	#instVars : [
		'parameters',
		'functionName'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpFunctionInvocation >> children [
	| result |
	result := super children.
	result addAll: parameters.
	functionName ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #initialization }
GtPhpFunctionInvocation >> initialize [
	super initialize.
	parameters := OrderedCollection new.

]
