Extension { #name : #CPPMemberDeclarationNode }

{ #category : #'*Famix-CPP' }
CPPMemberDeclarationNode >> isClassSpecifier [
	^ specifiers
		anySatisfy: [ :each | each isKindOf: CPPClassSpecifierNode ]
]

{ #category : #'*Famix-CPP' }
CPPMemberDeclarationNode >> isEnumSpecifier [
	^ specifiers
		anySatisfy: [ :each | each isKindOf: CPPEnumSpecifierNode ]
]

{ #category : #'*Famix-CPP' }
CPPMemberDeclarationNode >> isForwardDeclaration [
	^ specifiers
		anySatisfy: [ :each | each isKindOf: CPPElaboratedTypeSpecifierNode ]
]

{ #category : #'*Famix-CPP' }
CPPMemberDeclarationNode >> isFriendDeclaration [
	^ specifiers
		anySatisfy: [ :each | 
			(each isKindOf: CPPDeclSpecifierNode)
				and: [ each name source = 'friend' ] ]
]

{ #category : #'*Famix-CPP' }
CPPMemberDeclarationNode >> isTypedef [
	| typeNode |
	self specifiers size >= 2
		ifFalse: [ ^ false ].
	((self specifiers first isKindOf: CPPDeclSpecifierNode)
		and: [ self specifiers first source = 'typedef' ])
		ifFalse: [ ^ false ].
	self declarators isEmpty
		ifFalse: [ ^ self specifiers size = 2
				and: [ self declarators first isKindOf: CPPMemberDeclaratorNode ] ].
	typeNode := self specifiers second.
	^ (typeNode isKindOf: CPPClassTypeNode)
		or: [ (typeNode isKindOf: CPPClassSpecifierNode)
				or: [ (typeNode isKindOf: CPPEnumSpecifierNode)
						or: [ typeNode isKindOf: CPPElaboratedTypeSpecifierNode ] ] ]
]

{ #category : #'*Famix-CPP' }
CPPMemberDeclarationNode >> typedefName [
	^ declarators notEmpty
		ifTrue: [ (declarators first isKindOf: CPPMemberDeclaratorNode)
				ifTrue: [ declarators first declarator id source ] ]
		ifFalse: [ specifiers last source ]
]
