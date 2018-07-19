Class {
	#name : #PBProjectContextOfFullBrowser,
	#superclass : #ClyFullBrowserContext,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #'selection strategy' }
PBProjectContextOfFullBrowser class >> selectionStrategy [
	<classAnnotation>
	
	^ClyContextSelectionStrategy for: ClyFullBrowser selectionType: PBAbstractUIItem  
]

{ #category : #accesing }
PBProjectContextOfFullBrowser >> package [
	^self lastSelectedObjectIn: self selectedPackages
]

{ #category : #'selection-projects' }
PBProjectContextOfFullBrowser >> selectedPackageItems [
	^ selectedItems select: [ :each | each isBasedOnItemType: CGOOngoingPackageUnit ]
]

{ #category : #'selection-projects' }
PBProjectContextOfFullBrowser >> selectedProjectItems [

	^selectedItems collect: [ :each | each rootParentItem ]
]