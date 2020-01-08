Class {
	#name : #'IG2020_Tr1Main',
	#superclass : #Object,
	#instVars : [
		'rootPath',
		'sourcePath',
		'diseased',
		'allSamples'
	],
	#category : #'IG2020_Tr001'
}

{ #category : #examples }
IG2020_Tr1Main class >> example01 [

	(self readFrom: 'D:\Hernan\Proyectos\Por-Usuario\Gaby\') diff inspect
]

{ #category : #examples }
IG2020_Tr1Main class >> example02 [

	(self readFrom: '/Users/mvs/IGEVET/gaby/') diff inspect
]

{ #category : #'instance creation' }
IG2020_Tr1Main class >> readFrom: aStringPath [

	^ self new rootPath: aStringPath 

]

{ #category : #accessing }
IG2020_Tr1Main >> allSamples [
	^ allSamples
]

{ #category : #accessing }
IG2020_Tr1Main >> allSamples: anObject [
	allSamples := anObject
]

{ #category : #comparing }
IG2020_Tr1Main >> compareAll_vs_Diseased [

	^ (self allSamples samples difference: self diseased samples) inspect


]

{ #category : #comparing }
IG2020_Tr1Main >> diff [

	self readAllSamples.
	self readDiseasedSamples.
	self compareAll_vs_Diseased.
]

{ #category : #accessing }
IG2020_Tr1Main >> diseased [
	^ diseased
]

{ #category : #accessing }
IG2020_Tr1Main >> diseased: anObject [
	diseased := anObject
]

{ #category : #reading }
IG2020_Tr1Main >> lcNormalize: aString [

	^ aString ifNotNil: [ : l | l asLowercase ] ifNil: [ String empty ]
]

{ #category : #reading }
IG2020_Tr1Main >> readAllSamples [

	sourcePath := rootPath , 'HC_TODOS_201'.
	allSamples := BioSampleCollection new.
	1 to: 7 do: [ : idx | 
		(sourcePath , idx asString , '.csv') asFileReference readStreamDo: [ : readStream |
		(NeoCSVReader on: readStream) 
				separator: $;;
				skipHeader;
				do: [ : row | 
					allSamples addBioSample: (IG2020_Tr1Sample new
						location: (self lcNormalize: row first); 
						breed: (self lcNormalize: row second);
						age: row third;
						sex: (self sexNormalize: row);
						weight: nil;
						condition: nil) ] ] ].

]

{ #category : #reading }
IG2020_Tr1Main >> readDiseasedSamples [

	diseased := BioSampleCollection new.
	(rootPath , 'HC_T2_Perros-RLC.csv') asFileReference readStreamDo: [ : readStream |
		(NeoCSVReader on: readStream) 
				separator: $;;
				skipHeader;
				do: [ : row | 
					diseased addBioSample: (IG2020_Tr1Sample new
						year: row second;
						breed: (self lcNormalize: row third);
						age: row seventh;
						sex: row fourth asUppercase first asString) ] ].

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

	^ row fourth  
		ifNotNil: [ : m | 'M' ] 
		ifNil: [ row fifth 
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
