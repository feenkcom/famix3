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
		filter: GTFilterSubstrings;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #accessing }
TGtPhpTypeDeclaration >> methods [
	^ self block childrenSelect: [ :anAstNode |
		anAstNode isKindOf: GtPhpMethodDeclaration ] 
]

{ #category : #printing }
TGtPhpTypeDeclaration >> mooseNameOn: stream [
	super mooseNameOn: stream.
	stream 
		nextPutAll: ' (';
		nextPutAll: self classNameValue;
		nextPutAll: ')'
]
