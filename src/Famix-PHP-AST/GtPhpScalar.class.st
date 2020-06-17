Class {
	#name : #GtPhpScalar,
	#superclass : #GtPhpVariableBase,
	#traits : 'TGtPhpScalar',
	#classTraits : 'TGtPhpScalar classTrait',
	#instVars : [
		'value',
		'type'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpScalar >> scalarType [
	^ type
]

{ #category : #accessing }
GtPhpScalar >> stringValue [
	^ value
]
