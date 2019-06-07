Extension { #name : #CPPSimpleDeclarationNode }

{ #category : #'*Famix-CPP' }
CPPSimpleDeclarationNode >> isSimpleTypedef [
	| typeNode |
	self specifiers size = 3
		ifFalse: [ ^ false ].
	self declarators isEmpty
		ifFalse: [ ^ false ].
	((self specifiers first isKindOf: CPPDeclSpecifierNode)
		and: [ self specifiers first source = 'typedef' ])
		ifFalse: [ ^ false ].
	typeNode := self specifiers second.
	^ (typeNode isKindOf: CPPClassTypeNode)
		or: [ (typeNode isKindOf: CPPClassSpecifierNode)
				or: [ typeNode isKindOf: CPPEnumSpecifierNode ] ]
]
