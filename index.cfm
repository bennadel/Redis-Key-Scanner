<cfscript>

	if ( ! application.scanner.isConfigured() ) {

		location( url = "./configure.cfm" );

	}

</cfscript>
<cfoutput>
	
	<!doctype html>
	<html lang="en">
	<head>
		<meta charset="utf-8" />

		<title>
			Redis Scanner
		</title>

		<link rel="stylesheet" type="text/css" href="./styles.css" />
	</head>
	<frameset cols="50%,50%">
		<frame name="list" src="./list.cfm" />
		<frame name="detail" src="./detail.cfm" />
	</frameset>
	</html>

</cfoutput>
