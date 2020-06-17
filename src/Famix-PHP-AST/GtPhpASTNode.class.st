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
GtPhpASTNode >> ast [
	^ ast
]

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
GtPhpASTNode >> flags [
	^ flags
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
GtPhpASTNode >> location [
	^ location
]

{ #category : #accessing }
GtPhpASTNode >> parent [
	^ parent
]

{ #category : #accessing }
GtPhpASTNode >> property1 [
	^ property1
]

{ #category : #accessing }
GtPhpASTNode >> property2 [
	^ property2
]

{ #category : #accessing }
GtPhpASTNode >> start [
	^ start
]

{ #category : #accessing }
GtPhpASTNode >> start: anObject [
	start := anObject
]
