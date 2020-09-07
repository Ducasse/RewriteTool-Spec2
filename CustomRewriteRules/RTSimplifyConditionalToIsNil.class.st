"
I am a Demo Rewrite Rule.
"
Class {
	#name : #RTSimplifyConditionalToIsNil,
	#superclass : #RBTransformationRule,
	#category : #'CustomRewriteRules-Demo'
}

{ #category : #initialization }
RTSimplifyConditionalToIsNil >> initialize [
	
	| searchForPattern replaceWithPattern |
	super initialize.
	searchForPattern := '`@receiver ifNil: [ true ] ifNotNil: [ false ]'.
	replaceWithPattern := '`@receiver isNil'.
	rewriteRule replace: searchForPattern with: replaceWithPattern
]