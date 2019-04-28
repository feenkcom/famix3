"
An invocation with its arguments.
These are FamixAssociations or nil

e.g. ""obj.mth( var, 1, fct(3) )""

would be an FamixInvocation of ""mth/3"" (receiver=""obj"") with 3 arguments:
- FamixAccess to FamixStructuralEntity ""var""
- nil
- FamixInvocation of FamixFunction ""fct/1""
"
Class {
	#name : #FAMIXInvocationWithArgs,
	#superclass : #FAMIXInvocation,
	#instVars : [
		'arguments'
	],
	#category : #'Famix-CPlusPlus'
}

{ #category : #'fame annotation' }
FAMIXInvocationWithArgs class >> annotation [
	<MSEClass: #InvocationWithArgs super: #FAMIXInvocation>
	<package: #FAMIX>
]

{ #category : #accessing }
FAMIXInvocationWithArgs >> addArgument: anAssociation [
	arguments add: anAssociation
]

{ #category : #accessing }
FAMIXInvocationWithArgs >> arguments [
	<MSEProperty: #arguments type: #FAMIXAssociation>
	"Opposite not recorded, but (arguments allSatisfy: [:arg | self from = arg from])"
	<multivalued>
	<MSEComment: 'List of associations resulting of passing arguments to the invoked behavioural'>
	^ arguments
]

{ #category : #accessing }
FAMIXInvocationWithArgs >> arguments: aCollection [ 
	arguments nocheckValue: aCollection
]

{ #category : #'initialize-release' }
FAMIXInvocationWithArgs >> initialize [
	super initialize.
	arguments := FMMultivalueLink new.
]
