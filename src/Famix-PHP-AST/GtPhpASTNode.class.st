Class {
	#name : #GtPhpASTNode,
	#superclass : #GtPhpObject,
	#instVars : [
		'length',
		'property1',
		'start',
		'parent',
		'flags',
		'location',
		'ast',
		'property2'
	],
	#category : #'Famix-PHP-AST'
}

{ #category : #accessing }
GtPhpASTNode >> children [
	| result |
	result := super children.
	parent ifNotNil: [ :x | result add: x ].
	location ifNotNil: [ :x | result add: x ].
	ast ifNotNil: [ :x | result add: x ].
	^ result
]

{ #category : #accessing }
GtPhpASTNode >> length [
	^ length
]

{ #category : #accessing }
GtPhpASTNode >> length: anObject [
	length := anObject
]

{ #category : #accessing }
GtPhpASTNode >> start [
	^ start
]

{ #category : #accessing }
GtPhpASTNode >> start: anObject [
	start := anObject
]
