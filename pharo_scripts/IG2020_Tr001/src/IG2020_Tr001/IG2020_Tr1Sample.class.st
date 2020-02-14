Class {
	#name : #'IG2020_Tr1Sample',
	#superclass : #BioSample,
	#instVars : [
		'year',
		'breed',
		'age',
		'sex',
		'weight',
		'condition'
	],
	#category : #'IG2020_Tr001'
}

{ #category : #comparing }
IG2020_Tr1Sample >> < anIG2020_Tr1Sample [

	self breed < anIG2020_Tr1Sample breed 
		and: [ self sex < anIG2020_Tr1Sample sex 
			and: [ self age < anIG2020_Tr1Sample age ] ]
]

{ #category : #comparing }
IG2020_Tr1Sample >> = anIG2020_Tr1Sample [

	self class = anIG2020_Tr1Sample class
		ifFalse: [ ^ false ].
	self sex = anIG2020_Tr1Sample sex
		ifFalse: [ ^ false ].
	self breed = anIG2020_Tr1Sample breed
		ifFalse: [ ^ false ].
	self age = anIG2020_Tr1Sample age
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #accessing }
IG2020_Tr1Sample >> age [
	^ age
]

{ #category : #accessing }
IG2020_Tr1Sample >> age: anObject [
	age := anObject
]

{ #category : #accessing }
IG2020_Tr1Sample >> breed [
	^ breed
]

{ #category : #accessing }
IG2020_Tr1Sample >> breed: anObject [
	breed := anObject
]

{ #category : #accessing }
IG2020_Tr1Sample >> condition [
	^ condition
]

{ #category : #accessing }
IG2020_Tr1Sample >> condition: anObject [
	condition := anObject
]

{ #category : #comparing }
IG2020_Tr1Sample >> hash [ 

	^ self location hash bitXor: (self breed hash bitXor: self age hash)
]

{ #category : #accessing }
IG2020_Tr1Sample >> location [
	^ location
]

{ #category : #accessing }
IG2020_Tr1Sample >> location: anObject [
	location := anObject
]

{ #category : #printing }
IG2020_Tr1Sample >> printOn: aStream [

	aStream
		nextPutAll: self breed between: $[ and: $];
		nextPutAll: self sex between: $- and: $- onNilPut: '?';
		nextPutAll: self age onNilPut: '?'
]

{ #category : #accessing }
IG2020_Tr1Sample >> sex [
	^ sex
]

{ #category : #accessing }
IG2020_Tr1Sample >> sex: anObject [
	sex := anObject
]

{ #category : #accessing }
IG2020_Tr1Sample >> weight [
	^ weight
]

{ #category : #accessing }
IG2020_Tr1Sample >> weight: anObject [
	weight := anObject
]

{ #category : #accessing }
IG2020_Tr1Sample >> year [
	^ year
]

{ #category : #accessing }
IG2020_Tr1Sample >> year: anObject [
	year := anObject
]
