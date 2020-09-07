"
I am a Demo Rewrite Rule.
"
Class {
	#name : #RTChangeSelectToReject,
	#superclass : #RBTransformationRule,
	#category : #'CustomRewriteRules-Demo'
}

{ #category : #initialization }
RTChangeSelectToReject >> initialize [

	| searchForPattern replaceWithPattern |
	super initialize.
	searchForPattern :=  '`@receiver select: [:`each | | `@temps | ``@.Statements. ``@object not]'.
	replaceWithPattern := '`@receiver reject: [:`each | | `@temps | ``@.Statements. ``@object]'.
	rewriteRule replace: searchForPattern with: replaceWithPattern
]