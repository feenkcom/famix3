Extension { #name : #FAMIXSourcedEntity }

{ #category : #'*Famix-PHP' }
FAMIXSourcedEntity >> gtInspectorPhpAstIn: composite [
	<gtInspectorPresentationOrder: 40>
	self hasPhpAst ifTrue: [ (self phpAst gtInspectorChildrenIn: composite) title: 'AST' ]
]

{ #category : #'*Famix-PHP' }
FAMIXSourcedEntity >> gtInspectorPhpSourceAstIn: composite [
	<gtInspectorPresentationOrder: 40>
	self hasPhpAst ifTrue: [ (self phpAst gtInspectorSourceIn: composite) title: 'AST Source' ]
]

{ #category : #'*Famix-PHP' }
FAMIXSourcedEntity >> hasPhpAst [
	^ self sourceAnchor notNil and: [
		[ (self sourceAnchor fileReference withoutExtension, 'ast') exists ]
			on: Error 
			do: [ false ] ]
]

{ #category : #'*Famix-PHP' }
FAMIXSourcedEntity >> phpAst [
	^ self privateState 
		attributeAt: #phpAst 
		ifAbsentPut: [
			| program |
			program := GtPhpProgram new importFromFile: (self sourceAnchor fileReference withoutExtension, 'ast').
			program fileReference: self sourceAnchor fileReference.
			(program deep: #children select: [ :each | each start asNumber = self sourceAnchor startPos]) anyOne ]
]

{ #category : #'*Famix-PHP' }
FAMIXSourcedEntity >> phpAst: anAst [
	self privateState 
		attributeAt: #phpAst 
		put: anAst
]

{ #category : #'*Famix-PHP' }
FAMIXSourcedEntity >> phpAstStrings [
	self hasPhpAst ifFalse: [ ^ #() ].
	^ (self phpAst 
		allChildrenSelect: [ :child |
			child class = GtPhpScalar and: [ (child instVarNamed: #type) = 'string' ] ])
]
