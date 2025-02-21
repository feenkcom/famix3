Extension { #name : #String }

{ #category : #'*Famix-PHP-Symfony' }
String >> asGtPhpCammelCaseFromUnderscore [
    | substrings |
    substrings := self substrings: (CharacterSet newFrom: '_').
    ^ (String streamContents: [:stream |
               substrings do: [:sub |
                       stream nextPutAll: sub capitalized]]). 
]

{ #category : #'*Famix-PHP-Symfony' }
String >> asGtPhpUnderscoreFromCamelCase [
   | substrings |
  	substrings := self piecesCutWhereCamelCase.
	^ String streamContents: [:s | 
		(substrings collect: #asLowercase) asStringOn: s delimiter: '_'].

   
]
