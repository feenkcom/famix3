"
A TOODependencyQueries defines a vocabulary to compute dependencies of object-oriented entities.

For more informations: https://moosequery.ferlicot.fr/
"
Trait {
	#name : #TOODependencyQueries,
	#traits : 'TDependencyQueries',
	#classTraits : 'TDependencyQueries classTrait',
	#category : #'Moose-Query'
}

{ #category : #'moosequery-queries-incoming' }
TOODependencyQueries >> queryIncomingTypeDeclarationsIn: aCollection [
	"This method could be more readable but it needs to be really performant"

	| selectors |
	1 to: (selectors := self childrenSelectors) size do: [ :index | 
		(self perform: (selectors at: index))
			ifNotNil: [ :children | 
				| coll |
				1 to: (coll := children asFamixCollection) size do: [ :i | (coll at: i) queryIncomingTypeDeclarationsIn: aCollection ] ] ].
	aCollection addAll: self incomingTypeDeclarations.
	^ aCollection
]

{ #category : #'moosequery-queries-outgoing' }
TOODependencyQueries >> queryOutgoingTypeDeclarationsIn: aCollection [
	"This method could be more readable but it needs to be really performant"

	| selectors |
	1 to: (selectors := self childrenSelectors) size do: [ :index | 
		(self perform: (selectors at: index))
			ifNotNil: [ :children | 
				| coll |
				1 to: (coll := children asFamixCollection) size do: [ :i | (coll at: i) queryOutgoingTypeDeclarationsIn: aCollection ] ] ].
	aCollection addAll: self outgoingTypeDeclarations.
	^ aCollection
]
