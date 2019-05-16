Extension { #name : #MooseAbstractGroup }

{ #category : #'*Famix-C' }
MooseAbstractGroup >> allCFiles [
	<navigation: 'All C files'>
	^ self allWithType: FAMIXCFile
]

{ #category : #'*Famix-C' }
MooseAbstractGroup >> allHeaders [
	<navigation: 'All headers'>
	^ self allWithType: FAMIXHeader  
]

{ #category : #'*Famix-C' }
MooseAbstractGroup >> allIncludes [
	<navigation: 'All includes'>
	^ self allWithType: FAMIXInclude
]

{ #category : #'*Famix-C' }
MooseAbstractGroup >> allModules [
	<navigation: 'All modules'>
	^ self allWithType: FAMIXModule  
]

{ #category : #'*Famix-C' }
MooseAbstractGroup >> allTypeAliases [
	<navigation: 'All type aliases'>
	^ self allWithType: FAMIXTypeAlias
]
