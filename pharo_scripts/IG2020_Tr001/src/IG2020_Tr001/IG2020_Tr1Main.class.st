"
LR 51 -> (as bag: 40) (assigned: ) (unassigned: 4)
RLCC 72 -> (as bag: 56) (assigned: ) (unassigned: 16)
"
Class {
	#name : #'IG2020_Tr1Main',
	#superclass : #Object,
	#instVars : [
		'rootPath',
		'sourcePath',
		'allSamples',
		'diseasedLR',
		'diseasedRLCC',
		'unassignedRLCC',
		'unassignedLR'
	],
	#category : #'IG2020_Tr001'
}

{ #category : #examples }
IG2020_Tr1Main class >> example01_Win [

	(self readFrom: 'D:\Hernan\Proyectos\Por-Usuario\Gaby\') diff inspect
]

{ #category : #examples }
IG2020_Tr1Main class >> example02_Unix [

	(self readFrom: '/Users/mvs/IGEVET/gaby/') assignConditions inspect
]

{ #category : #examples }
IG2020_Tr1Main class >> example03_Unix_GroupBy [

	(self readFrom: '/Users/mvs/IGEVET/gaby/') assignConditionRLCC inspect
]

{ #category : #'instance creation' }
IG2020_Tr1Main class >> readFrom: aStringPath [

	^ self new rootPath: aStringPath 

]

{ #category : #reading }
IG2020_Tr1Main >> ageNormalize: row [
	" Normalize to days "

	^ row fifth  
		ifNotNil: [ : m | m isNumeric 
			ifTrue: [ m asNumber ]
			ifFalse: [ 0 ] ]
		ifNil: [ self halt. ]
		

]

{ #category : #accessing }
IG2020_Tr1Main >> allSamples [

	^ allSamples samples
]

{ #category : #accessing }
IG2020_Tr1Main >> allSamples: anObject [
	allSamples := anObject
]

{ #category : #comparing }
IG2020_Tr1Main >> assignConditionLR [

"	self allSamples select: [ : e | e breed asLowercase = 'pitbull' ]."
	self diseasedSamplesLR asBag doWithOccurrences: [ : s : count | 	
		(self allSamples select: [ : as | as = s and: [ as condition = 0 ] ])
			ifNotEmpty: [ : c | 1 to: count do: [ : idx | (c at: idx) condition: 2  ] ]
			ifEmpty: [ self unassignedLR add: s ] ].
]

{ #category : #comparing }
IG2020_Tr1Main >> assignConditionRLCC [

"	self allSamples select: [ : e | e breed asLowercase = 'pitbull' ]."
	self diseasedSamplesRLCC asBag doWithOccurrences: [ : s : count | 	
		(self allSamples select: [ : as | as = s and: [ as condition = 0 ] ])
			ifNotEmpty: [ : c | 1 to: count do: [ : idx | (c at: idx) condition: 1  ] ]
			ifEmpty: [ self unassignedRLCC add: s ] ].
]

{ #category : #comparing }
IG2020_Tr1Main >> assignConditions [

	self readAllSamples_v2.
	self readDiseasedSamplesRLCC.
	self readDiseasedSamplesLR.
	self assignConditionLR.
	self assignConditionRLCC.
	Transcript clear; show: self report.
]

{ #category : #comparing }
IG2020_Tr1Main >> assignedConditionLR [

	^ self allSamples select: [ : s | s condition = 2 ]
]

{ #category : #comparing }
IG2020_Tr1Main >> assignedConditionRLCC [

	^ self allSamples select: [ : s | s condition = 1 ]
]

{ #category : #accessing }
IG2020_Tr1Main >> diseasedLR [
	^ diseasedLR
]

{ #category : #accessing }
IG2020_Tr1Main >> diseasedLR: anObject [
	diseasedLR := anObject
]

{ #category : #accessing }
IG2020_Tr1Main >> diseasedRLCC [
	^ diseasedRLCC
]

{ #category : #accessing }
IG2020_Tr1Main >> diseasedRLCC: anObject [
	diseasedRLCC := anObject
]

{ #category : #accessing }
IG2020_Tr1Main >> diseasedSamplesLR [

	^ self diseasedLR samples
]

{ #category : #accessing }
IG2020_Tr1Main >> diseasedSamplesRLCC [

	^ self diseasedRLCC samples
]

{ #category : #reading }
IG2020_Tr1Main >> initialize [

	super initialize.
	self unassignedLR: OrderedCollection new.
	self unassignedRLCC: OrderedCollection new
]

{ #category : #reading }
IG2020_Tr1Main >> isValidSampleValue: aValue [

	^ aValue notNil and: [ aValue asNumber ~= 0 ]
		

]

{ #category : #reading }
IG2020_Tr1Main >> lcNormalize: aString [

	^ aString ifNotNil: [ : l | l asLowercase trimBoth ] ifNil: [ String empty ]
]

{ #category : #reading }
IG2020_Tr1Main >> readAllSamples_v2 [
	" Condition:
		0 - Healthy 
		1 - RLCC 
		2 - LR "
	sourcePath := (rootPath , 'HC_TODOS.csv') asFileReference.
	allSamples := BioSampleCollection new.
	sourcePath readStreamDo: [ : readStream |
		(NeoCSVReader on: readStream) 
				separator: $,;
				skipHeader;
				do: [ : row | 
					(self isValidSampleValue: row fifth)
						ifTrue: [ 
							allSamples addBioSample: (IG2020_Tr1Sample new
								year: row first;
								location: (self lcNormalize: row second); 
								breed: (self lcNormalize: row third);
								age: (self ageNormalize: row);
								sex: (self sexNormalize: row);
								weight: nil;
								condition: 0) ] ] ].

]

{ #category : #reading }
IG2020_Tr1Main >> readDiseasedSamplesLR [

	diseasedLR := self readDiseasedSamplesLR: rootPath , 'HC_T2_Perros-LR.csv'
]

{ #category : #reading }
IG2020_Tr1Main >> readDiseasedSamplesLR: fileName [

	| diseased |
	diseased := BioSampleCollection new.
	fileName asFileReference readStreamDo: [ : readStream |
		(NeoCSVReader on: readStream) 
				separator: $,;
				skipHeader;
				do: [ : row | 
					(self isValidSampleValue: row sixth)
						ifTrue: [ 
							diseased addBioSample: (IG2020_Tr1Sample new
								year: row second;
								breed: (self lcNormalize: row third);
								age: row sixth asNumber;
								sex: row fourth asUppercase first asString) ] ] ].
	^ diseased
]

{ #category : #reading }
IG2020_Tr1Main >> readDiseasedSamplesRLCC [

	diseasedRLCC := self readDiseasedSamplesRLCC: rootPath , 'HC_T2_Perros-RLCC.csv'
]

{ #category : #reading }
IG2020_Tr1Main >> readDiseasedSamplesRLCC: fileName [

	| diseased |
	diseased := BioSampleCollection new.
	fileName asFileReference readStreamDo: [ : readStream |
		(NeoCSVReader on: readStream) 
				separator: $,;
				skipHeader;
				do: [ : row | 
					(self isValidSampleValue: row eighth)
						ifTrue: [ 
							diseased addBioSample: (IG2020_Tr1Sample new
								year: row second;
								breed: (self lcNormalize: row third);
								age: row eighth asNumber;
								sex: row fourth asUppercase first asString) ] ] ].
	^ diseased
]

{ #category : #results }
IG2020_Tr1Main >> report [

	self writeCSVReport.
	^ self userFriendlyReport
]

{ #category : #accessing }
IG2020_Tr1Main >> rootPath [
	^ rootPath
]

{ #category : #accessing }
IG2020_Tr1Main >> rootPath: anObject [
	rootPath := anObject
]

{ #category : #reading }
IG2020_Tr1Main >> sexNormalize: row [

	(row sixth notNil and: [ row seventh notNil ])
		ifTrue: [ ^ 'UNKNOWN' ].
	^ row sixth  
		ifNotNil: [ : m | 'M' ] 
		ifNil: [ row seventh  
			ifNotNil: [ : h | 'H' ] 
			ifNil: [ 'UNKNOWN' ] ]
]

{ #category : #accessing }
IG2020_Tr1Main >> sourcePath [
	^ sourcePath
]

{ #category : #accessing }
IG2020_Tr1Main >> sourcePath: anObject [
	sourcePath := anObject
]

{ #category : #accessing }
IG2020_Tr1Main >> unassignedLR [
	^ unassignedLR
]

{ #category : #accessing }
IG2020_Tr1Main >> unassignedLR: anObject [
	unassignedLR := anObject
]

{ #category : #accessing }
IG2020_Tr1Main >> unassignedRLCC [
	^ unassignedRLCC
]

{ #category : #accessing }
IG2020_Tr1Main >> unassignedRLCC: anObject [
	unassignedRLCC := anObject
]

{ #category : #results }
IG2020_Tr1Main >> userFriendlyReport [
	^ String
		streamContents: [ :s | 
			s
				nextPutAll: 'Assigned LR: ';
				nextPutAll: (self allSamples count: [ :dog | dog condition = 2 ]) asString;
				cr;
				cr;
				nextPutAll: 'Assigned RLCC: ';
				nextPutAll: (self allSamples count: [ :dog | dog condition = 1 ]) asString;
				cr;
				cr;
				nextPutAll: 'Unassigned RLCC:';
				cr.
			self unassignedRLCC printOn: s delimiter: String cr.
			s
				cr;
				cr;
				nextPutAll: 'Unassigned: LR: '.
			self unassignedLR printOn: s delimiter: String cr ]
]

{ #category : #results }
IG2020_Tr1Main >> writeCSVReport [
	
	'report.csv' asFileReference writeStreamDo: [ :stream |
		| csv |
		csv := (NeoCSVWriter on: stream) 
			fieldWriter: #raw;
			separator: Character tab;
			writeHeader: #('BREED' 'SEX' 'AGE_DAYS' 'CONDITION').
		 self allSamples do: [ : ds |
			csv
				writeField: ds breed;
				writeSeparator;
				writeField: ds sex;
				writeSeparator;
				writeField: ds age asString;
				writeSeparator;
				writeField: ds condition asString;
				writeEndOfLine  ].
		csv flush ]
]
