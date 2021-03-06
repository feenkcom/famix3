"
Description
--------------------

Result of a navigation query for the outgoing associations of an entity.
"
Class {
	#name : #MooseOutgoingQueryResult,
	#superclass : #MooseQueryResult,
	#traits : 'TDependencyQueryResult',
	#classTraits : 'TDependencyQueryResult classTrait',
	#category : #'Moose-Query'
}

{ #category : #private }
MooseOutgoingQueryResult >> isOppositeMultivalued: aDependency [
	^ (aDependency class mooseDescription attributes
		detect: [ :att | att isTarget ]) isMultivalued
]

{ #category : #private }
MooseOutgoingQueryResult >> opposite: aDependency [

	^ aDependency to
]

{ #category : #accessing }
MooseOutgoingQueryResult >> opposites [
	^ self newObjectResultWith: (self storage flatCollectAsSet: [ :d | (self opposite: d) asFamixCollection ])
]

{ #category : #accessing }
MooseOutgoingQueryResult >> sourceClasses [

	^ self sources collectAsSet: #typeScope
]

{ #category : #accessing }
MooseOutgoingQueryResult >> sources [

	^ self collectAsSet: #from
]

{ #category : #filtering }
MooseOutgoingQueryResult >> withoutSelfLoops [
	"exclude dependencies which loop back to the receiver"

	^ self reject: [ :dep | (self opposite: dep) asFamixCollection anySatisfy: [ :opp | opp withAllParents includes: self receiver ] ]
]
