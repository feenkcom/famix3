Class {
	#name : #GtPhpAssignment,
	#superclass : #GtPhpExpression,
	#instVars : [
		'operator',
		'value',
		'variableBase'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpAssignment >> children [
	| result |
	result := super children.
	variableBase ifNotNil: [ :x | result add: x ].
	value ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpAssignment >> operator [
	^ operator
]

{ #category : #accessing }
GtPhpAssignment >> value [
	^ value
]

{ #category : #accessing }
GtPhpAssignment >> variableBase [
	^ variableBase
]
