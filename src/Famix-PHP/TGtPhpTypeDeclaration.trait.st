Trait {
	#name : #TGtPhpTypeDeclaration,
	#category : #'Famix-PHP-Traits-AST'
}

{ #category : #accessing }
TGtPhpTypeDeclaration >> classNameValue [
	^ self className name
]

{ #category : #'tool-extensions' }
TGtPhpTypeDeclaration >> gtSearchMethodsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Methods';
		allCandidates: [ self methods ];
		itemName: #methodNameValue;
		filter: GtFilterSubstrings;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #accessing }
TGtPhpTypeDeclaration >> methods [
	^ self block childrenSelect: [ :anAstNode |
		anAstNode isKindOf: GtPhpMethodDeclaration ] 
]

{ #category : #printing }
TGtPhpTypeDeclaration >> shortDescriptionOn: aStream [
	aStream nextPutAll: self classNameValue
]
