Class {
	#name : #DemoRule1,
	#superclass : #RBTransformationRule,
	#category : #'RewriteToolCustomRules-Demo'
}

{ #category : #initialization }
DemoRule1 >> initialize [
	super initialize.
	self rewriteRule
		replace:
			'`variable1 isNil
	ifTrue: `@block1.
`.Statement1'
		with:
			'`variable1 ifNil: `@block1.
`.Statement1'
]

{ #category : #accessing }
DemoRule1 >> someMethod [
	self ifNil: [ ^ true ].
	super size
]