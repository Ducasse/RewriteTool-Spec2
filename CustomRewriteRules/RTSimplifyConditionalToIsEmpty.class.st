"
I am a Demo Rewrite Rule.
"
Class {
	#name : #RTSimplifyConditionalToIsEmpty,
	#superclass : #RBTransformationRule,
	#category : #'CustomRewriteRules-Demo'
}

{ #category : #initialization }
RTSimplifyConditionalToIsEmpty >> initialize [

	| searchForPattern replaceWithPattern |
	super initialize.
	searchForPattern := '`@receiver ifEmpty: [ true ] ifNotEmpty: [ false ]'.
	replaceWithPattern := '`@receiver isEmpty'.
	rewriteRule replace: searchForPattern with: replaceWithPattern
]