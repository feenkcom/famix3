Class {
	#name : #GtPhpSymphonyEntitiesGenerator,
	#superclass : #Object,
	#category : #'Famix-PHP-Symfony'
}

{ #category : #'as yet unclassified' }
GtPhpSymphonyEntitiesGenerator >> generateAccessorMethodForASTNodeClass: aFamixClass in: namespace [
	(aFamixClass attributes, ((aFamixClass outgoingTraitUsages collect: #to) flatCollect: #attributes))
		reject: #hasClassScope
		thenDo: [ :anAttribute | 
			| attributeName getterSource setterSource |
			attributeName := self instVarNameForAttribute: anAttribute.
			getterSource := attributeName, String cr, String tab, '^ ', attributeName.	
			setterSource := attributeName asSymbol asMutator, ' ', 'anObject', String cr, String tab, attributeName, ' := ', 'anObject'.
	
			(RBSilentlyAddMethodRefactoring 
				model: namespace
				addMethod: getterSource
				toClass: (self pharoClassName: aFamixClass name) asSymbol
				inProtocols: #(#accessing)) primitiveExecute.
			(RBSilentlyAddMethodRefactoring 
				model: namespace
				addMethod: setterSource
				toClass: (self pharoClassName: aFamixClass name) asSymbol
				inProtocols: #(#accessing)) primitiveExecute ]

]

{ #category : #'as yet unclassified' }
GtPhpSymphonyEntitiesGenerator >> generateClass: aFamixClass [
	| namespace |
	namespace := RBNamespace onEnvironment: RBBrowserEnvironment new.
	self generateClass: aFamixClass in: namespace inPackageNamed: ''.
	^ namespace
]

{ #category : #'as yet unclassified' }
GtPhpSymphonyEntitiesGenerator >> generateClass: aFamixClass in: namespace inPackageNamed: aSymbol [
	(RBAddClassWithVarsRefactoring
		model: namespace
		addClass: (self pharoClassName: aFamixClass name)
		superclass:
		(aFamixClass superclass
				ifNil: [ self pharoClassName: '' ]
				ifNotNil: [ self pharoClassName: aFamixClass superclass name ])
		subclasses: {}
		category: aSymbol)
		instanceVariableNames:
			(aFamixClass attributes
				,
					((aFamixClass outgoingTraitUsages collect: #to)
						flatCollect: #attributes)
				reject: #hasClassScope
				thenCollect: [ :attribute | self instVarNameForAttribute: attribute ]);
		primitiveExecute.
	aFamixClass directSubclasses
		do: [ :each | self generateClass: each in: namespace inPackageNamed: aSymbol ].
	^ self
		generateAccessorMethodForASTNodeClass: aFamixClass
		in: namespace
]

{ #category : #'as yet unclassified' }
GtPhpSymphonyEntitiesGenerator >> generateEntitiesFromMooseModel: aMooseModel inPackageNamed: aSymbol [
	| namespace rootMooseEntities |
	rootMooseEntities := aMooseModel allModelClasses
		select: [ :each | each isPhpSymfonyEntity and: [ each superclass isNil ] ].
	namespace := RBNamespace onEnvironment: RBBrowserEnvironment new.
	(RBAddClassWithVarsRefactoring
		model: namespace
		addClass: (self pharoClassName: '')
		superclass: Object
		subclasses: {}
		category: aSymbol) primitiveExecute.
	rootMooseEntities
		do: [ :aFamixClass | self generateClass: aFamixClass in: namespace inPackageNamed: aSymbol ].
	^ namespace
]

{ #category : #private }
GtPhpSymphonyEntitiesGenerator >> instVarNameForAttribute: aFamixAttribute [
	^ ((aFamixAttribute name beginsWith: '$')
		ifTrue: [ aFamixAttribute name removePrefix: '$' ] 
		ifFalse: [ aFamixAttribute name ]) asGtPhpCammelCaseFromUnderscore uncapitalized
]

{ #category : #private }
GtPhpSymphonyEntitiesGenerator >> pharoClassName: aString [
	^ ('GtSym', (aString ifEmpty: ['Entity'])) asSymbol
]
