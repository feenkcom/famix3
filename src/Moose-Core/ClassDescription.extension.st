Extension { #name : #ClassDescription }

{ #category : #'*Moose-Core' }
ClassDescription >> @ aSymbol [
	"TheRoot@#TheRootSharedVariable"
	"TheRoot class@#uniqueInstance"
	
	<localClassDescriptionMethod> 
    "This method is supposed to be local in ClassDescription because in TClassDescription it
	 would cause conflict with TraitDescription>>@. We use this pragma to test if Trait does 
    not contain some accidental local selectors."

	^ ((aSymbol first isUppercase
		ifTrue: [self instanceSide]
		ifFalse: [self]) mooseName, '.', aSymbol ) asSymbol
]

{ #category : #'*Moose-Core' }
ClassDescription >> asMooseDescription [
	"
	In case you have created your own subclass of MooseEntity, and #asMooseDescription returns nil, you may want to do 'MooseModel resetMeta'. Naturally, you need to have the proper annotation on the class side of your class. 
	"

	^ MooseModel meta descriptionOf: self instanceSide
]
