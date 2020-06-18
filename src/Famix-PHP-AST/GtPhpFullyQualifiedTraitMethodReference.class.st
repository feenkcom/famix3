Class {
	#name : #GtPhpFullyQualifiedTraitMethodReference,
	#superclass : #GtPhpExpression,
	#instVars : [
		'functionName',
		'className'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpFullyQualifiedTraitMethodReference >> children [
	| result |
	result := super children.
	functionName ifNotNil: [ :x | result add: x ].
	className ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpFullyQualifiedTraitMethodReference >> className [
	^ className
]

{ #category : #accessing }
GtPhpFullyQualifiedTraitMethodReference >> functionName [
	^ functionName
]
