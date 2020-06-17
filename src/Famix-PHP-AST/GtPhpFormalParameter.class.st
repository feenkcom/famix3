Class {
	#name : #GtPhpFormalParameter,
	#superclass : #GtPhpASTNode,
	#instVars : [
		'isVariadic',
		'parameterName',
		'defaultValue',
		'isMandatory',
		'type'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpFormalParameter >> children [
	| result |
	result := super children.
	type ifNotNil: [ :x | result add: x ].
	parameterName ifNotNil: [ :x | result add: x ].
	defaultValue ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpFormalParameter >> defaultValue [
	^ defaultValue
]

{ #category : #accessing }
GtPhpFormalParameter >> isMandatory [
	^ isMandatory
]

{ #category : #accessing }
GtPhpFormalParameter >> isVariadic [
	^ isVariadic
]

{ #category : #accessing }
GtPhpFormalParameter >> parameterName [
	^ parameterName
]

{ #category : #accessing }
GtPhpFormalParameter >> type [
	^ type
]
