Extension { #name : #TClassDescription }

{ #category : #'*Moose-Core' }
TClassDescription >> asMooseDescription [
	"
	In case you have created your own subclass of MooseEntity, and #asMooseDescription returns nil, you may want to do 'MooseModel resetMeta'. Naturally, you need to have the proper annotation on the class side of your class. 
	"
	^MooseModel meta descriptionOf: self theNonMetaClass 
]
