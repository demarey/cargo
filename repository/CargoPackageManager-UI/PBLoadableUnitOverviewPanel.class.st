"
I'm in charge of displaying core meta-information on packages.
I also allow to edit these meta-data.

I mainly interacte with OnGoingPackage[Unit/Assembly]

"
Class {
	#name : #PBLoadableUnitOverviewPanel,
	#superclass : #PBLoadableUnitPanel,
	#instVars : [
		'nameLabel',
		'nameInputField',
		'versionLabel',
		'versionInputField',
		'descriptionLabel',
		'descriptionText',
		'registry',
		'loadableUnit',
		'autoAccept'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #specs }
PBLoadableUnitOverviewPanel class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ : column | 
			column
				newRow: [ :nameRow |
					nameRow 
						add: #nameLabel width: self labelSize;
						add: #nameInputField ]
				height: self inputTextHeight;
				newRow: [ :versionRow |
					versionRow 
						add: #versionLabel width: self labelSize;
						add: #versionInputField ]
				height: self inputTextHeight;
				add: #descriptionLabel height: self inputTextHeight;
			 	add: #descriptionText ]
]

{ #category : #example }
PBLoadableUnitOverviewPanel class >> example [
	^ self openOn: (PBPackage example)
]

{ #category : #example }
PBLoadableUnitOverviewPanel class >> example2 [
	^ self openWithMinimalSpecOn: (PBPackage example)
]

{ #category : #specs }
PBLoadableUnitOverviewPanel class >> minimalSpec [
	^ SpecLayout composed
		newColumn: [ : column | 
			column
				newRow: [ :nameRow |
					nameRow 
						add: #nameLabel width: self labelSize;
						add: #nameInputField ]
				height: self inputTextHeight;
				add: #descriptionLabel height: self inputTextHeight;
			 	add: #descriptionText ]
]

{ #category : #'instance creation' }
PBLoadableUnitOverviewPanel class >> newOn: anOngoingPackageVersion owner: owner [
	^ self basicNew
		initializeWith: anOngoingPackageVersion;
		yourself
]

{ #category : #opening }
PBLoadableUnitOverviewPanel class >> openOn: anOngoingPackageVersion [
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithSpec
]

{ #category : #opening }
PBLoadableUnitOverviewPanel class >> openWithMinimalSpecOn: anOngoingPackageVersion [
	(self newOn: anOngoingPackageVersion owner: nil)
		openWithSpec: #minimalSpec
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> accept [

	self
		updateName;
		updateVersion;
		updateDescription
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> descriptionLabel [
	^ descriptionLabel
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> descriptionText [
	^ descriptionText
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> initialExtent [
	 ^ (900.0@350.0)
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> initialize [

	registry := CGOPackageRegistry default.
	super initialize.
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> initializePresenter [

	"nameInputField acceptBlock: [ self error: 'Project name should not change' ]."
	versionInputField acceptBlock: [ self updateVersion ].
	descriptionText whenTextIsAccepted: 
		[ :newText | self updateDescription ]
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> initializeWidgets [
	(nameLabel := self newLabel)
		label: 'Name:'.
	self newTextInputField: #nameInputField description: 'MyProject'.
		
	(versionLabel := self newLabel)
		label: 'Version:'.
	self newTextInputField: #versionInputField description: '1.0.0'. 
		
	(descriptionLabel := self newLabel)
		label: 'Description:'.
	descriptionText := self newText
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> initializeWith: anOngoingPackageUnit [
	self initialize.
	loadableUnit := anOngoingPackageUnit.
	self refreshWidgetValues
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> loadableUnit [
	^ loadableUnit
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> loadableUnit: anObject [
	loadableUnit := anObject
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> nameInputField [
	^ nameInputField
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> nameLabel [
	^ nameLabel
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> project [
	self shouldBeImplemented.
]

{ #category : #initialization }
PBLoadableUnitOverviewPanel >> refreshWidgetValues [
	nameInputField text: loadableUnit name.
	versionInputField text: loadableUnit version asString.
	descriptionText text: loadableUnit description
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> registry [
	^ registry
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> registry: aCGOPackageRegistry [

	registry := aCGOPackageRegistry 
]

{ #category : #updating }
PBLoadableUnitOverviewPanel >> updateDescription [
	loadableUnit description: descriptionText text asString
]

{ #category : #updating }
PBLoadableUnitOverviewPanel >> updateName [
	loadableUnit name: nameInputField text asSymbol
]

{ #category : #updating }
PBLoadableUnitOverviewPanel >> updateVersion [
	| versionString |
	versionString := versionInputField text.
	versionString asSemanticVersion. "check the version string"
	loadableUnit version: versionString
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> versionInputField [
	^ versionInputField
]

{ #category : #accessing }
PBLoadableUnitOverviewPanel >> versionLabel [
	^ versionLabel
]