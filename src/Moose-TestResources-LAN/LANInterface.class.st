"
LAN Interface comments for testing purposes.

Instance Variables:
	addressee	<ValueHolder>	description of addressee
	contents	<ValueHolder>	description of contents
	deviceNameMenu	<ValueModel>	description of deviceNameMenu
	nextNode	<ValueHolder>	description of nextNode
	nodeList	<SelectionInList>	description of nodeList
	nodeName	<ValueHolder>	description of nodeName
	originator	<ValueHolder>	description of originator


"
Class {
	#name : #LANInterface,
	#superclass : #Object,
	#traits : 'TLANInterface',
	#classTraits : 'TLANInterface classTrait',
	#instVars : [
		'nodeName',
		'nodeList',
		'nextNode',
		'deviceNameMenu',
		'contents',
		'originator',
		'addressee'
	],
	#category : #'Moose-TestResources-LAN'
}

{ #category : #'interface specs' }
LANInterface class >> originateDialog [ 
	"UIPainter new openOnClass: self andSelector: #originateDialog" 
	 
	<resource: #canvas> 
	^#(#FullSpec  
		#window: #(#WindowSpec  
			#label: 'Originate'  
			#bounds: #(#Rectangle 301 390 587 741)  
			#flags: 8)  
		#component: #(#SpecCollection  
			#collection: #(#(#LabelSpec  
				#layout: #(#AlignmentOrigin 0 0.5 2 0 0.5 0)  
				#label: 'Originate a new packet') #(#LabelSpec  
				#layout: #(#Point 3 30)  
				#label: 'Originator') #(#LabelSpec  
				#layout: #(#Point 3 95)  
				#label: 'Addressee') #(#LabelSpec  
				#layout: #(#Point 3 160)  
				#label: 'Contents') #(#MenuButtonSpec  
				#layout: #(#LayoutFrame 10 0 55 0 -10 1 80 0)  
				#model: #originator  
				#menu: #originators) #(#MenuButtonSpec  
				#layout: #(#LayoutFrame 10 0 120 0 -10 1 145 0)  
				#model: #addressee  
				#menu: #addressees) #(#TextEditorSpec  
				#layout: #(#LayoutFrame 10 0 185 0 -10 1 -40 1)  
				#model: #contents) #(#ActionButtonSpec  
				#layout: #(#LayoutFrame 20 0 -30 1 -50 0.5 -3 1)  
				#model: #accept  
				#label: 'Accept') #(#ActionButtonSpec  
				#layout: #(#LayoutFrame 50 0.5 -30 1 -20 1 -3 1)  
				#model: #cancel  
				#label: 'Cancel'))))
]

{ #category : #'interface specs' }
LANInterface class >> windowSpec [ 
	"UIPainter new openOnClass: self andSelector: #windowSpec" 
	 
	<resource: #canvas> 
	^#(#FullSpec  
		#window: #(#WindowSpec  
			#label: 'Local Area Network'  
			#bounds: #(#Rectangle 189 174 816 582))  
		#component: #(#SpecCollection  
			#collection: #(#(#GroupBoxSpec  
				#layout: #(#LayoutFrame 5 0 0 0 -120 1 50 0)  
				#label: 'Create') #(#ActionButtonSpec  
				#layout: #(#Rectangle 20 20 120 45)  
				#model: #newWorkstation  
				#label: 'Workstation') #(#ActionButtonSpec  
				#layout: #(#Rectangle 140 20 240 45)  
				#model: #newNode  
				#label: 'Node') #(#ActionButtonSpec  
				#layout: #(#Rectangle 260 20 360 45)  
				#model: #newPrintServer  
				#label: 'PrintServer') #(#ActionButtonSpec  
				#layout: #(#Rectangle 380 20 480 45)  
				#model: #newFileServer  
				#label: 'FileServer') #(#ActionButtonSpec  
				#layout: #(#LayoutFrame -105 1 20 0 -5 1 45 0)  
				#name: #removeButton  
				#model: #remove  
				#label: 'Remove') #(#SequenceViewSpec  
				#layout: #(#LayoutFrame 5 0 60 0 -5 1 -130 1)  
				#name: #nodeList  
				#flags: 15  
				#model: #nodeList  
				#useModifierKeys: true  
				#selectionType: #highlight) #(#LabelSpec  
				#layout: #(#LayoutOrigin 5 0 -110 1)  
				#label: 'Name:') #(#LabelSpec  
				#layout: #(#LayoutOrigin 5 0 -75 1)  
				#label: 'Next Node:') #(#ActionButtonSpec  
				#layout: #(#LayoutFrame -50 0.5 -30 1 50 0.5 -5 1)  
				#name: #originateButton  
				#model: #originate  
				#label: 'Originate') #(#InputFieldSpec  
				#layout: #(#LayoutFrame 80 0 -110 1 300 0 -85 1)  
				#name: #nodeName  
				#model: #nodeName  
				#callbacksSpec: #(#UIEventCallbackSubSpec #valueChangeSelector:)  
				#type: #symbol) #(#MenuButtonSpec  
				#layout: #(#LayoutFrame 80 0 -75 1 300 0 -50 1)  
				#name: #nextNodeMenu  
				#model: #nextNode  
				#callbacksSpec: #(#UIEventCallbackSubSpec #valueChangeSelector:)  
				#menu: ))))
]

{ #category : #actions }
LANInterface >> accept [ 
	"This stub method was generated by UIDefiner" 
	 
	^self
]

{ #category : #aspects }
LANInterface >> addressee [ 
	"This method was generated by UIDefiner.  Any edits made here 
	may be lost whenever methods are automatically defined.  The 
	initialization provided below may have been preempted by an 
	initialize method." 
	 
	^addressee isNil 
		ifTrue: [addressee := nil asValue] 
		ifFalse: [addressee]
]

{ #category : #actions }
LANInterface >> cancel [ 
	"This stub method was generated by UIDefiner" 
	 
	^self
]

{ #category : #aspects }
LANInterface >> contents [ 
	"This method was generated by UIDefiner.  Any edits made here 
	may be lost whenever methods are automatically defined.  The 
	initialization provided below may have been preempted by an 
	initialize method." 
	 
	^contents isNil 
		ifTrue: [contents := String new asValue] 
		ifFalse: [contents]
]

{ #category : #'initialize-release' }
LANInterface >> initialize [ 
	 
	| selectionHolder | 
	super initialize. 
	self flag: #commentedForSq.
	"self nodeList list: DependentList new. 
	selectionHolder := self nodeList selectionHolder. 
	nodeName := (AspectAdaptor forAspect: #name) subjectChannel: 
			selectionHolder. 
	nextNode := (AspectAdaptor forAspect: #nextNode) 
		subjectChannel: selectionHolder; 
		subjectSendsUpdates: true"
]

{ #category : #actions }
LANInterface >> newFileServer [ 
	 
	^self nodeList list add: LANFileServer new
]

{ #category : #actions }
LANInterface >> newNode [ 
	 
	^self nodeList list add: LANNode new
]

{ #category : #actions }
LANInterface >> newPrintServer [ 
	 
	^self nodeList list add: LANPrintServer new
]

{ #category : #actions }
LANInterface >> newWorkstation [ 
	 
	^self nodeList list add: LANWorkStation new
]

{ #category : #aspects }
LANInterface >> nextNode [ 
	"This method was generated by UIDefiner.  Any edits made here 
	may be lost whenever methods are automatically defined.  The 
	initialization provided below may have been preempted by an 
	initialize method." 
	 
	^nextNode isNil 
		ifTrue: [nextNode := nil asValue] 
		ifFalse: [nextNode]
]

{ #category : #aspects }
LANInterface >> nodeList [ 
	"This method was generated by UIDefiner.  Any edits made here 
	may be lost whenever methods are automatically defined.  The 
	initialization provided below may have been preempted by an 
	initialize method." 
	 
	^true 
	
	"nodeList isNil 
		ifTrue: [nodeList := SelectionInList new] 
		ifFalse: [nodeList]"
]

{ #category : #aspects }
LANInterface >> nodeName [ 
	"This method was generated by UIDefiner.  Any edits made here 
	may be lost whenever methods are automatically defined.  The 
	initialization provided below may have been preempted by an 
	initialize method." 
	 
	^nodeName isNil 
		ifTrue: [nodeName := nil asValue] 
		ifFalse: [nodeName]
]

{ #category : #'as yet unclassified' }
LANInterface >> originate [ 
	 
	| dialogModel dialogBuilder returnVal packet dialogOriginator dialogAddressee dialogContents | 
	"the next three lines create ValueHolders to support the three dialog widgets" 
	dialogOriginator := nil asValue. 
	dialogAddressee := nil asValue. 
	dialogContents := String new asValue.	"next two lines create a new SimpleDialog object and retrieves the builder" 
	dialogModel := Smalltalk at: #SimpleDialog new. 
	dialogBuilder := dialogModel builder.	"the following lines connect  the widgets of the interface with the ValueHolders created" 
	dialogBuilder aspectAt: #originator put: dialogOriginator. 
	dialogBuilder aspectAt: #addressee put: dialogAddressee. 
	dialogBuilder aspectAt: #contents put: dialogContents.	"the following lines ask the LANInterface for the originators and outputters menus.  
	You will write these next, so select proceed when VisualWorks when VisualWorks indicates that they are new messages." 
	returnVal := dialogModel openFor: self interface: #originateDialog.	"returnvalue will be true if the user selected Accept, otherwise it will be false" 
	returnVal 
		ifTrue: 
			["create a new packet, fill it in and give it to the workstation" 
			packet := (LANPacket new) 
				addressee: 
						(LANSingleDestinationAddress new id: dialogAddressee value name); 
				contents: dialogContents value. 
			dialogOriginator value originate: packet]
]

{ #category : #aspects }
LANInterface >> originator [ 
	"This method was generated by UIDefiner.  Any edits made here 
	may be lost whenever methods are automatically defined.  The 
	initialization provided below may have been preempted by an 
	initialize method." 
	 
	^originator isNil 
		ifTrue: [originator := nil asValue] 
		ifFalse: [originator]
]

{ #category : #actions }
LANInterface >> remove [
	| sel |
	(sel := self nodeList selection) ifNotNil: [ self nodeList list remove: sel ]
]
