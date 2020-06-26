"
I am a tool that allows to create and apply custom rewrite rules. I provide a simple GUI that has to code editors: searchFor and replaceWith. Also, I have a mini cheat sheet for the rewrite rules syntax, and some buttons for action.

To run:
RewriteBasicEditorPresenter open

Instance Variables
	searchForEditor:		<SearchForCodePresenter>
	replaceWithEditor:		<ReplaceWithCodePresenter>
	cheatSheet:				<SpTextPresenter>
	applyButton: 			<SpButtonPresenter>
	saveButton: 				<SpButtonPresenter>
	loadButton: 				<SpButtonPresenter>
	
	
searchForEditor
	- The code editor for write the ""search for"" part of the rule.

replaceWithEditor
	- The code editor for write the ""replace with"" part of the rule.

cheatSheet
	- A mini cheat sheet to show the rewrite rules syntax.

applyButton
	- Opens the RewriteBrowserPresenter.

saveButton
	- A button to save the rule.
	
loadButton
	- Opens the LoadRulePresenter.

"
Class {
	#name : #RewriteBasicEditorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'methodCheckBox',
		'applyButton',
		'cheatSheet',
		'saveButton',
		'loadButton',
		'searchForEditor',
		'replaceWithEditor'
	],
	#category : #'RewriteRuleEditor-BasicEditor'
}

{ #category : #specs }
RewriteBasicEditorPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: #searchForEditor
					expand: true
					fill: true
					padding: 2;
				add: #replaceWithEditor
					expand: true
					fill: true
					padding: 2;
				yourself)
			expand: true;
		add:
			(SpBoxLayout newVertical
				add: #cheatSheet expand: true;
				addLast: #applyButton;
				addLast: #saveButton;
				addLast: #loadButton;
				yourself)
			expand: false;
		yourself
]

{ #category : #defaults }
RewriteBasicEditorPresenter class >> icon [
	^ self iconNamed: #workspaceIcon
]

{ #category : #specs }
RewriteBasicEditorPresenter class >> open [
	<script>
	^ self new openWithSpec
]

{ #category : #accesing }
RewriteBasicEditorPresenter >> applierIcon [
	^ RewriteRuleApplierPresenter icon
]

{ #category : #defaults }
RewriteBasicEditorPresenter >> createRuleClass: aRuleName forPackage: aPackageName [
	^ CustomRuleGenerator new
		searchFor: searchForEditor text;
		replaceWith: replaceWithEditor text;
		generateRule: aRuleName forPackage: aPackageName
]

{ #category : #accesing }
RewriteBasicEditorPresenter >> helpText [
	^ '` = meta var
			
@ = list

` = recurse into

. = statement

# = literal'
]

{ #category : #initialization }
RewriteBasicEditorPresenter >> initializePresenters [
	" Method checkbox has no functionality yet"

	"	methodCheckBox := self newCheckBox
		label: 'Method';
		yourself.
	searchForEditor := (self instantiate: SearchForCodePresenter)
		codeSource: (self defaultRule at: #searchFor);
		yourself.
	replaceWithEditor := (self instantiate: ReplaceWithCodePresenter)
		codeSource: (self defaultRule at: #replaceWith);
		yourself."

	cheatSheet := self newText
		text: self helpText;
		enabled: false;
		yourself.
	searchForEditor := self newCode
		text: DefaultRewriteRule new searchFor;
		yourself.
	replaceWithEditor := self newCode
		text: DefaultRewriteRule new replaceWith;
		yourself.
	loadButton := self newButton
		label: 'Load rule';
		icon: self loadRuleIcon;
		action: [ self openRuleLoader ];
		yourself.
	saveButton := self newButton
		label: 'Save rule';
		icon: (self iconNamed: #smallSaveAs);
		action: [ self saveRule ];
		yourself.
	applyButton := self newButton
		label: 'Open applier';
		icon: self applierIcon;
		action: [ self openApplier ];
		yourself.
	self focusOrder
		add: loadButton;
		add: searchForEditor;
		add: replaceWithEditor;
		add: cheatSheet;
		add: methodCheckBox;
		add: saveButton;
		add: applyButton
]

{ #category : #initialization }
RewriteBasicEditorPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Rewrite Basic Editor';
		initialExtent: 700 @ 500;
		windowIcon: self class icon;
		askOkToClose: false;
		aboutText: 'A simple UI to create Rewrite Rules';
		whenOpenedDo: [ cheatSheet color: self theme baseColor ]
]

{ #category : #accesing }
RewriteBasicEditorPresenter >> loadRuleIcon [
	^ LoadRewriteRulePresenter icon
]

{ #category : #actions }
RewriteBasicEditorPresenter >> openApplier [
	^ RewriteRuleApplierPresenter open
]

{ #category : #actions }
RewriteBasicEditorPresenter >> openRuleLoader [
	^ LoadRewriteRulePresenter open
]

{ #category : #api }
RewriteBasicEditorPresenter >> replaceWithCode: aCode [
	replaceWithEditor text: aCode
]

{ #category : #defaults }
RewriteBasicEditorPresenter >> ruleNotCreatedAlert [
	UIManager default
		alert: 'The name(s) you enter is invalid. Please try again.'
		title: 'Alert'
]

{ #category : #defaults }
RewriteBasicEditorPresenter >> ruleSuccessfullyCreatedAlert [
	UIManager default alert: 'The rule was successfully created!'
]

{ #category : #actions }
RewriteBasicEditorPresenter >> saveRule [
	| ruleName packageName |
	ruleName := UIManager default
		request: 'Name of the Rule: '
		initialAnswer: ''.
	packageName := UIManager default
		request: 'Name of the Package: '
		initialAnswer: 'Custom'.
	(self createRuleClass: ruleName forPackage: packageName)
		ifFalse: [ self ruleNotCreatedAlert ].
	self ruleSuccessfullyCreatedAlert
]

{ #category : #api }
RewriteBasicEditorPresenter >> searchForCode: aCode [
	searchForEditor text: aCode
]