Iceberg
	enableMetacelloIntegration: true;
	remoteTypeSelector: #httpsUrl.
Metacello new
    baseline: 'BioSmalltalk';
    repository: 'github://hernanmd/biosmalltalk/repository';
	onConflictUseIncoming;
	onWarningLog;
    load.
SmalltalkImage current saveAs: 'BioSmalltalk'.
SmalltalkImage current snapshot: true andQuit: true.
