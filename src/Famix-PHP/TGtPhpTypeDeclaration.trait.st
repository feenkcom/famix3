Trait {
	#name : #TGtPhpTypeDeclaration,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #'tool-extensions' }
TGtPhpTypeDeclaration >> gtSearchMethodsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Methods';
		allCandidates: [ self methods ];
		itemName: #methodNameValue;
		filter: GTFilterSubstrings;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #accessing }
TGtPhpTypeDeclaration >> methods [
	^ self block childrenSelect: [ :anAstNode |
		anAstNode isKindOf: GtPhpMethodDeclaration ] 
]
