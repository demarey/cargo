Class {
	#name : #PBPackageAnnouncementTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
PBPackageAnnouncementTest >> setUp [

	super setUp.
	testRegistry registerInSystem
]

{ #category : #tests }
PBPackageAnnouncementTest >> tearDown [

	('Test-APackage' asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem.
	('Test-APackageNew' asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem.

	super tearDown
]

{ #category : #tests }
PBPackageAnnouncementTest >> testPackageRemovedFromSystemKeptThePackageInTheProjectButNotInstalled [

	project := testRegistry newProjectNamed: 'Test'.
	project createPackageNamed: 'Test-APackage'.
	
	'Test-APackage' asPackage removeFromSystem.
	
	self assert: (project hasPackageNamed: 'Test-APackage').
	self deny: (project packageNamed: 'Test-APackage') isInstalled
]

{ #category : #tests }
PBPackageAnnouncementTest >> testPackageRemovedFromSystemUpdateRegistry [

	project := testRegistry newProjectNamed: 'Test'.
	project createPackageNamed: 'Test-APackage'.
	
	'Test-APackage' asPackage removeFromSystem.
	
	self deny: (testRegistry hasInstalledPackageNamed: 'Test::Test-APackage')
]

{ #category : #tests }
PBPackageAnnouncementTest >> testPackageRenamedUpdateProject [

	project := testRegistry newProjectNamed: 'Test'.
	project createPackageNamed: 'Test-APackage'.
	
	'Test-APackage' asPackage renameTo: 'Test-APackageNew'.
	
	self assert: (project hasPackageNamed: 'Test-APackageNew').
	self deny: (project hasPackageNamed: 'Test-APackage').	
]

{ #category : #tests }
PBPackageAnnouncementTest >> testPackageRenamedUpdateRegistry [

	project := testRegistry newProjectNamed: 'Test'.
	project createPackageNamed: 'Test-APackage'.
	
	'Test-APackage' asPackage renameTo: 'Test-APackageNew'.
	
	self deny: (testRegistry hasInstalledPackageNamed: 'Test::Test-APackage').
	self assert: (testRegistry hasInstalledPackageNamed: 'Test::Test-APackageNew')	
]