Extension { #name : #CPPSimpleDeclarationNode }

{ #category : #'*Famix-CPP' }
CPPSimpleDeclarationNode >> isExternalFunction [
	declarators size = 1
		ifFalse: [ ^ false ].
	^ declarators first declarator leftParens notEmpty
		and: [ (self parentOfType: CPPFunctionDefinitionNode) isNil ]
]

{ #category : #'*Famix-CPP' }
CPPSimpleDeclarationNode >> isTypedef [
	| typeNode |
	self specifiers size >= 2
		ifFalse: [ ^ false ].
	((self specifiers first isKindOf: CPPDeclSpecifierNode)
		and: [ self specifiers first source = 'typedef' ])
		ifFalse: [ ^ false ].
	self declarators isEmpty
		ifFalse: [ ^ false ].
	typeNode := self specifiers second.
	^ (typeNode isKindOf: CPPClassTypeNode)
		or: [ (typeNode isKindOf: CPPClassSpecifierNode)
				or: [ (typeNode isKindOf: CPPEnumSpecifierNode)
						or: [ typeNode isKindOf: CPPElaboratedTypeSpecifierNode ] ] ]
]

{ #category : #'*Famix-CPP' }
CPPSimpleDeclarationNode >> typedefName [
	^ declarators notEmpty
		ifFalse: [ specifiers last source ]
]
