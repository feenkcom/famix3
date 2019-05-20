Class {
	#name : #FAMIXPreprocessedCppSourceLanguage,
	#superclass : #FAMIXCppSourceLanguage,
	#instVars : [
		'preprocessor'
	],
	#category : #'Famix-CPP'
}

{ #category : #accessing }
FAMIXPreprocessedCppSourceLanguage >> preprocessor: anObject [
	preprocessor := anObject
]
