Class {
	#name : #FAMIXPackageNavigationChefTest,
	#superclass : #AbstractFAMIXNavigationTest,
	#category : #'Moose-Tests-SmalltalkImporter-KGB-MooseChef'
}

{ #category : #allDependencies }
FAMIXPackageNavigationChefTest >> testClientClasses [
	| p5 |
	p5 := self packageP5FullReferee.
	self
		assert:
			((p5 queryAllIncoming atScope: FAMIXType)
				equalsTo:
					((Set
						with: self c1FullReferencerOutSide
						with: self c14ReferencerOutSideRefereeOutSide
						with: self c6FullReferencerInSideOutSide
						with: self c3ReferencerInSideRefereeOutSide) union: (Set with: self c11FullRefereeOutSide)))
]

{ #category : #allDependencies }
FAMIXPackageNavigationChefTest >> testClientClassesInto [
	| p1 p5 |
	p1 := self packageP1FullReferencer.
	p5 := self packageP5FullReferee.
	self assert: (((p5 queryAllIncoming atScope: FAMIXType) withinPackage: p1) equalsTo: (Set with: self c1FullReferencerOutSide))
]

{ #category : #allDependencies }
FAMIXPackageNavigationChefTest >> testClientPackages [
	| p1 p2 p3 p5 p7 |
	p1 := self packageP1FullReferencer.
	p2 := self packageP2InteractedReferencerReferee.
	p3 := self packageP3InteractedReferencer.
	p5 := self packageP5FullReferee.
	p7 := self packageP7ReferencerReferee.
	self
		assert:
			((p5 queryAllIncoming atScope: FAMIXPackage)
				equalsTo:
					(Set
						with: p1
						with: p2
						with: p7
						with: p3
						with: p5))
]

{ #category : #'MooseKGB-TestFamix3-integralTests' }
FAMIXPackageNavigationChefTest >> testEachOutgoingReferenceImpliesAnIncomingReference [
	| modelPackages |
	modelPackages := self model allPackages.
	self
		assert:
			(modelPackages
				allSatisfy: [ :referencer | 
					(referencer queryAllOutgoingInvocations atScope: FAMIXType)
						allSatisfy: [ :referenced | 
							(referenced queryAllIncomingInvocations atScope: FAMIXPackage)
								includes: referencer ] ]).
	self
		assert:
			(modelPackages
				allSatisfy: [ :referencer | 
					(referencer queryAllOutgoingInvocations atScope: FAMIXPackage)
						allSatisfy: [ :referenced | 
							(referenced queryAllIncomingInvocations atScope: FAMIXPackage)
								includes: referencer ] ])
]

{ #category : #'MooseKGB-TestFamix3-integralTests' }
FAMIXPackageNavigationChefTest >> testEachStaticOutgoingReferenceImpliesAStaticIncomingReference [
	| modelPackages |
	modelPackages := self model allPackages.
	self
		assert:
			(modelPackages
				allSatisfy: [ :referencer | 
					(referencer queryOutgoingReferences atScope: FAMIXType)
						allSatisfy: [ :referenced | 
							(referenced queryIncomingReferences atScope: FAMIXPackage)
								includes: referencer ] ]).
	self
		assert:
			(modelPackages
				allSatisfy: [ :referencer | 
					(referencer queryOutgoingReferences atScope: FAMIXPackage)
						allSatisfy: [ :referenced | 
							(referenced queryIncomingReferences atScope: FAMIXPackage)
								includes: referencer ] ])
]

{ #category : #'MooseKGB-TestFamix3-integralTests' }
FAMIXPackageNavigationChefTest >> testEachSureOutgoingReferenceImpliesASureIncomingReference [
	| modelPackages |
	modelPackages := self model allPackages.
	self
		assert:
			(modelPackages
				allSatisfy: [ :referencer | 
					(referencer querySureOutgoingInvocations atScope: FAMIXType)
						allSatisfy: [ :referenced | 
							(referenced querySureIncomingInvocations atScope: FAMIXPackage)
								includes: referencer ] ]).
	self
		assert:
			(modelPackages
				allSatisfy: [ :referencer | 
					(referencer querySureOutgoingInvocations atScope: FAMIXPackage)
						allSatisfy: [ :referenced | 
							(referenced querySureIncomingInvocations atScope: FAMIXPackage)
								includes: referencer ] ])
]

{ #category : #inheritance }
FAMIXPackageNavigationChefTest >> testInheritedByClasses [ 
	 
	| p6 | 
	p6 := self packageP6InteractedReferee. 
	self 
		assert: 
			(p6 queryIncomingInheritances opposites equalsTo: (Set with: self c11FullRefereeOutSide))
]

{ #category : #inheritance }
FAMIXPackageNavigationChefTest >> testInheritedByClassesInto [ 
	 
	| p5 p6 | 
	p5 := self packageP5FullReferee. 
	p6 := self packageP6InteractedReferee. 
	self 
		assert: 
			((p6 queryIncomingInheritances opposites withinPackage: p5) 
				equalsTo: (Set with: self c11FullRefereeOutSide))
]

{ #category : #inheritance }
FAMIXPackageNavigationChefTest >> testInheritedByPackages [
	| p5 p6 |
	p5 := self packageP5FullReferee.
	p6 := self packageP6InteractedReferee.
	self
		assert:
			((p6 queryIncomingInheritances atScope: FAMIXPackage)
				equalsTo: (Set with: p5))
]

{ #category : #inheritance }
FAMIXPackageNavigationChefTest >> testInheritedClasses [ 
	 
	| p5 | 
	p5 := self packageP5FullReferee. 
	self 
		assert: 
			(p5 queryOutgoingInheritances opposites equalsTo: (Set with: self c12FullReferencerInSide))
]

{ #category : #inheritance }
FAMIXPackageNavigationChefTest >> testInheritedClassesInto [ 
	 
	| p5 p6 | 
	p5 := self packageP5FullReferee. 
	p6 := self packageP6InteractedReferee.  
	self 
		assert: 
			((p5 queryOutgoingInheritances opposites withinPackage: p6) 
				equalsTo: (Set with: self c12FullReferencerInSide))
]

{ #category : #inheritance }
FAMIXPackageNavigationChefTest >> testInheritedPackages [
	| p5 p6 |
	p5 := self packageP5FullReferee.
	p6 := self packageP6InteractedReferee.
	self
		assert:
			((p5 queryOutgoingInheritances atScope: FAMIXPackage)
				equalsTo: (Set with: p6))
]

{ #category : #allDependencies }
FAMIXPackageNavigationChefTest >> testProviderClasses [
	| p8 |
	p8 := self packageP8FullReferencer.
	self assert: ((p8 queryAllOutgoing atScope: FAMIXType) equalsTo: (Set with: self c18FullRefereeInSideOutSide with: self c19FullRefereeOutSide with: self c14ReferencerOutSideRefereeOutSide))
]

{ #category : #allDependencies }
FAMIXPackageNavigationChefTest >> testProviderClassesInto [
	| p8 p11 pEx |
	p8 := self packageP8FullReferencer.
	p11 := self packageP11FullReferee.
	pEx := self packagePExtensions.
	self assert: (((p8 queryAllOutgoing atScope: FAMIXType) withinPackage: p11) equalsTo: (Set with: self c19FullRefereeOutSide)).
	self assert: ((p8 queryAllOutgoing atScope: FAMIXType) withinPackage: pEx) isEmpty
]

{ #category : #allDependencies }
FAMIXPackageNavigationChefTest >> testProviderPackages [
	| p7 p8 p10 p11 pEx |
	p7 := self packageP7ReferencerReferee.
	p8 := self packageP8FullReferencer.
	p10 := self packageP10InteractedReferee.
	p11 := self packageP11FullReferee.
	pEx := self packagePExtensions.
	self
		assert:
			((p8 queryAllOutgoing atScope: FAMIXPackage)
				equalsTo:
					(Set
						with: p10
						with: p11
						with: p7
						with: pEx))
]

{ #category : #allOutgoingInvocations }
FAMIXPackageNavigationChefTest >> testReferencedClasses [
	self
		assert:
			((self packageP8FullReferencer queryAllOutgoingInvocations
				atScope: FAMIXType)
				equalsTo:
					(Set
						with: self c18FullRefereeInSideOutSide
						with: self c19FullRefereeOutSide))
]

{ #category : #allOutgoingInvocations }
FAMIXPackageNavigationChefTest >> testReferencedClassesInto [
	| p8 p11 pEx |
	p8 := self packageP8FullReferencer.
	p11 := self packageP11FullReferee.
	pEx := self packagePExtensions.
	self
		assert:
			(((p8 queryAllOutgoingInvocations atScope: FAMIXType)
				withinPackage: p11)
				equalsTo: (Set with: self c19FullRefereeOutSide)).
	self
		assert:
			((p8 queryAllOutgoingInvocations atScope: FAMIXType)
				withinPackage: pEx) isEmpty
]

{ #category : #allOutgoingInvocations }
FAMIXPackageNavigationChefTest >> testReferencedPackages [
	| p8 p10 p11 pEx |
	p8 := self packageP8FullReferencer.
	p10 := self packageP10InteractedReferee.
	p11 := self packageP11FullReferee.
	pEx := self packagePExtensions.
	self
		assert:
			((p8 queryAllOutgoingInvocations atScope: FAMIXPackage)
				equalsTo: (Set with: p10 with: p11 with: pEx)).
	self
		assert:
			((pEx queryAllOutgoingInvocations atScope: FAMIXPackage)
				equalsTo: (Set with: p11))
]

{ #category : #allIncomingInvocations }
FAMIXPackageNavigationChefTest >> testReferencingClasses [
	self
		assert:
			((self packageP5FullReferee queryAllIncomingInvocations
				atScope: FAMIXType)
				equalsTo:
					(Set
						with: self c1FullReferencerOutSide
						with: self c14ReferencerOutSideRefereeOutSide
						with: self c6FullReferencerInSideOutSide
						with: self c11FullRefereeOutSide))
]

{ #category : #allIncomingInvocations }
FAMIXPackageNavigationChefTest >> testReferencingClassesInto [
	| p1 p5 |
	p1 := self packageP1FullReferencer.
	p5 := self packageP5FullReferee.
	self
		assert:
			(((p5 queryAllIncomingInvocations atScope: FAMIXType)
				withinPackage: p1)
				equalsTo: (Set with: self c1FullReferencerOutSide))
]

{ #category : #allIncomingInvocations }
FAMIXPackageNavigationChefTest >> testReferencingPackages [
	self
		assert:
			((self packageP5FullReferee queryAllIncomingInvocations
				atScope: FAMIXPackage)
				equalsTo:
					(Set
						with: self packageP1FullReferencer
						with: self packageP3InteractedReferencer
						with: self packageP7ReferencerReferee
						with: self packageP5FullReferee))
]

{ #category : #inheritance }
FAMIXPackageNavigationChefTest >> testSourceClassesInInheritedClasses [ 
	| p3 | 
	p3 := self packageP3InteractedReferencer. 

	self assert: (p3 queryOutgoingInheritances sourceClasses
		equalsTo: (Set
					with: self c5ReferencerInSideRefereeInSide
					with: self c6FullReferencerInSideOutSide 
					with: self c7FullRefereeInSide 
					with: self c8FullReferencerInSide )).

	self assert: (p3 queryOutgoingInheritances withoutSelfLoops sourceClasses
		equalsTo: (Set
					with: self c5ReferencerInSideRefereeInSide
					with: self c6FullReferencerInSideOutSide 
					with: self c7FullRefereeInSide ))
]

{ #category : #allOutgoingInvocations }
FAMIXPackageNavigationChefTest >> testSourceClassesInReferencedClasses [
	
	self assert: (self packageP3InteractedReferencer queryAllOutgoingInvocations sourceClasses
		equalsTo: (Set
					with: self c5ReferencerInSideRefereeInSide 
					with: self c6FullReferencerInSideOutSide )).

]

{ #category : #staticDependencies }
FAMIXPackageNavigationChefTest >> testStaticClientClasses [
	| p5 |
	p5 := self packageP5FullReferee.
	self
		assert:
			((p5 queryStaticIncomingAssociations atScope: FAMIXType)
				equalsTo:
					(Set
						with: self c1FullReferencerOutSide
						with: self c14ReferencerOutSideRefereeOutSide
						with: self c6FullReferencerInSideOutSide
						with: self c3ReferencerInSideRefereeOutSide
						with: self c11FullRefereeOutSide))
]

{ #category : #staticDependencies }
FAMIXPackageNavigationChefTest >> testStaticClientClassesInto [
	| p1 p5 |
	p1 := self packageP1FullReferencer.
	p5 := self packageP5FullReferee.
	self
		assert:
			(((p5 queryStaticIncomingAssociations atScope: FAMIXType)
				withinPackage: p1)
				equalsTo: (Set with: self c1FullReferencerOutSide))
]

{ #category : #staticDependencies }
FAMIXPackageNavigationChefTest >> testStaticClientPackages [
	| p1 p2 p3 p5 p7 |
	p1 := self packageP1FullReferencer.
	p2 := self packageP2InteractedReferencerReferee.
	p3 := self packageP3InteractedReferencer.
	p5 := self packageP5FullReferee.
	p7 := self packageP7ReferencerReferee.
	self
		assert:
			((p5 queryStaticIncomingAssociations atScope: FAMIXPackage)
				equalsTo:
					(Set
						with: p1
						with: p2
						with: p7
						with: p3
						with: p5))
]

{ #category : #staticDependencies }
FAMIXPackageNavigationChefTest >> testStaticProviderClasses [
	| p8 |
	p8 := self packageP8FullReferencer.
	self
		assert:
			((p8 queryStaticOutgoingAssociations atScope: FAMIXType)
				equalsTo:
					(Set
						with: self c18FullRefereeInSideOutSide
						with: self c19FullRefereeOutSide
						with: self c14ReferencerOutSideRefereeOutSide))
]

{ #category : #staticDependencies }
FAMIXPackageNavigationChefTest >> testStaticProviderClassesInto [
	| p8 p11 pEx |
	p8 := self packageP8FullReferencer.
	p11 := self packageP11FullReferee.
	pEx := self packagePExtensions.
	self
		assert:
			(((p8 queryStaticOutgoingAssociations atScope: FAMIXType)
				withinPackage: p11)
				equalsTo: (Set with: self c19FullRefereeOutSide)).
	self
		assert:
			((p8 queryStaticOutgoingAssociations atScope: FAMIXType)
				withinPackage: pEx) isEmpty
]

{ #category : #staticDependencies }
FAMIXPackageNavigationChefTest >> testStaticProviderPackages [
	| p7 p8 p10 p11 |
	p7 := self packageP7ReferencerReferee.
	p8 := self packageP8FullReferencer.
	p10 := self packageP10InteractedReferee.
	p11 := self packageP11FullReferee.
	self
		assert:
			((p8 queryStaticOutgoingAssociations atScope: FAMIXPackage)
				equalsTo: (Set with: p10 with: p11 with: p7))
]

{ #category : #references }
FAMIXPackageNavigationChefTest >> testStaticReferencedClasses [
	| p8 |
	p8 := self packageP8FullReferencer.
	self
		assert:
			((p8 queryOutgoingReferences atScope: FAMIXType)
				equalsTo:
					(Set
						with: self c18FullRefereeInSideOutSide
						with: self c19FullRefereeOutSide))
]

{ #category : #references }
FAMIXPackageNavigationChefTest >> testStaticReferencedClassesInto [
	| p8 p11 pEx |
	p8 := self packageP8FullReferencer.
	p11 := self packageP11FullReferee.
	pEx := self packagePExtensions.
	self
		assert:
			(((p8 queryOutgoingReferences atScope: FAMIXType) withinPackage: p11)
				equalsTo: (Set with: self c19FullRefereeOutSide)).
	self
		assert:
			((p8 queryOutgoingReferences atScope: FAMIXType) withinPackage: pEx)
				isEmpty
]

{ #category : #references }
FAMIXPackageNavigationChefTest >> testStaticReferencedPackages [
	| p8 p10 p11 |
	p8 := self packageP8FullReferencer.
	p10 := self packageP10InteractedReferee.
	p11 := self packageP11FullReferee.
	self
		assert:
			((p8 queryOutgoingReferences atScope: FAMIXPackage)
				equalsTo: (Set with: p10 with: p11))
]

{ #category : #references }
FAMIXPackageNavigationChefTest >> testStaticReferencingClasses [
	| p5 |
	p5 := self packageP5FullReferee.
	self
		assert:
			((p5 queryIncomingReferences atScope: FAMIXType)
				equalsTo:
					(Set
						with: self c1FullReferencerOutSide
						with: self c14ReferencerOutSideRefereeOutSide
						with: self c6FullReferencerInSideOutSide
						with: self c11FullRefereeOutSide))
]

{ #category : #references }
FAMIXPackageNavigationChefTest >> testStaticReferencingClassesInto [
	| p1 p5 |
	p1 := self packageP1FullReferencer.
	p5 := self packageP5FullReferee.
	self
		assert:
			(((p5 queryIncomingReferences atScope: FAMIXType) withinPackage: p1)
				equalsTo: (Set with: self c1FullReferencerOutSide))
]

{ #category : #references }
FAMIXPackageNavigationChefTest >> testStaticReferencingPackages [
	| p1 p3 p5 p7 |
	p1 := self packageP1FullReferencer.
	p3 := self packageP3InteractedReferencer.
	p5 := self packageP5FullReferee.
	p7 := self packageP7ReferencerReferee.
	self
		assert:
			((p5 queryIncomingReferences atScope: FAMIXPackage)
				equalsTo:
					(Set
						with: p1
						with: p7
						with: p3
						with: p5))
]

{ #category : #sureOutgoingInvocations }
FAMIXPackageNavigationChefTest >> testSureReferencedClasses [
	| p8 |
	p8 := self packageP8FullReferencer.
	self
		assert:
			((p8 querySureOutgoingInvocations atScope: FAMIXType)
				equalsTo:
					(Set
						with: self c18FullRefereeInSideOutSide
						with: self c19FullRefereeOutSide))
]

{ #category : #'MooseKGB-TestFamix3-integralTests' }
FAMIXPackageNavigationChefTest >> testSureReferencedClassesIncludeAllStaticReferencedClasses [
	self
		assert:
			(self model allPackages
				allSatisfy: [ :referencer | 
					referencer querySureOutgoingAssociations
						includesAll: referencer queryStaticOutgoingAssociations ])
]

{ #category : #sureOutgoingInvocations }
FAMIXPackageNavigationChefTest >> testSureReferencedClassesInto [
	| p8 p11 pEx |
	p8 := self packageP8FullReferencer.
	p11 := self packageP11FullReferee.
	pEx := self packagePExtensions.
	self
		assert:
			(((p8 querySureOutgoingInvocations atScope: FAMIXType)
				withinPackage: p11)
				equalsTo: (Set with: self c19FullRefereeOutSide)).
	self
		assert:
			((p8 querySureOutgoingInvocations atScope: FAMIXType)
				withinPackage: pEx) isEmpty
]

{ #category : #sureOutgoingInvocations }
FAMIXPackageNavigationChefTest >> testSureReferencedPackages [
	| p8 p10 p11 pEx |
	p8 := self packageP8FullReferencer.
	p10 := self packageP10InteractedReferee.
	p11 := self packageP11FullReferee.
	pEx := self packagePExtensions.
	self
		assert:
			((p8 querySureOutgoingInvocations atScope: FAMIXPackage)
				equalsTo: (Set with: p10 with: p11 with: pEx))
]

{ #category : #sureIncomingInvocations }
FAMIXPackageNavigationChefTest >> testSureReferencingClasses [
	self
		assert:
			((self packageP5FullReferee querySureIncomingInvocations
				atScope: FAMIXType)
				equalsTo:
					(Set
						with: self c1FullReferencerOutSide
						with: self c14ReferencerOutSideRefereeOutSide
						with: self c6FullReferencerInSideOutSide
						with: self c11FullRefereeOutSide))
]

{ #category : #'MooseKGB-TestFamix3-integralTests' }
FAMIXPackageNavigationChefTest >> testSureReferencingClassesIncludeAllStaticReferencingClasses [ 
	 
	| modelPackages | 
	modelPackages := self model allPackages. 
	self 
		assert: 
			(modelPackages 
				allSatisfy: 
					[:referencer |  
					referencer querySureIncomingAssociations
						includesAll: referencer queryStaticIncomingAssociations])
]

{ #category : #sureIncomingInvocations }
FAMIXPackageNavigationChefTest >> testSureReferencingClassesInto [
	| p1 p5 |
	p1 := self packageP1FullReferencer.
	p5 := self packageP5FullReferee.
	self
		assert:
			(((p5 querySureIncomingInvocations atScope: FAMIXType)
				withinPackage: p1)
				equalsTo: (Set with: self c1FullReferencerOutSide))
]

{ #category : #sureIncomingInvocations }
FAMIXPackageNavigationChefTest >> testSureReferencingPackages [
	self
		assert:
			((self packageP5FullReferee querySureIncomingInvocations
				atScope: FAMIXPackage)
				equalsTo:
					(Set
						with: self packageP1FullReferencer
						with: self packageP7ReferencerReferee
						with: self packageP3InteractedReferencer
						with: self packageP5FullReferee))
]

{ #category : #allIncomingInvocations }
FAMIXPackageNavigationChefTest >> testTargetClassesInReferencingClasses [

	self assert: (self packageP5FullReferee queryAllIncomingInvocations targetClasses
		equalsTo: (Set with: self c11FullRefereeOutSide))
]

{ #category : #references }
FAMIXPackageNavigationChefTest >> testTargetClassesInStaticReferencingClasses [
 
	| p2 |
	p2 := self packageP2InteractedReferencerReferee. 

	self 
		assert: (p2 queryIncomingReferences targetClasses
		equalsTo: (Set
					with: self c2ReferencerOutSideRefereeInSide
					with: self c3ReferencerInSideRefereeOutSide
					with: self c4FullRefereeInSide )).
	self 
		assert: (p2 queryIncomingReferences withoutSelfLoops targetClasses
		equalsTo: (Set with: self c3ReferencerInSideRefereeOutSide )).
]
