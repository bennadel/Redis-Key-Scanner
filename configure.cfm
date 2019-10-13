<cfscript>

	param name = "form.host" type = "string" default = "";

	// Check to see if the form has been submitted.
	if ( form.host.len() ) {

		application.scanner.configure( form.host );

		location( url = "./index.cfm" );

	}

</cfscript>
<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<meta charset="utf-8" />

		<title>
			Configure Redis Scanner
		</title>

		<link rel="stylesheet" type="text/css" href="./styles.css" />
	</head>
	<body class="p-configure">

		<h1 class="title">
			Configure Redis Scanner
		</h1>

		<form method="post" action="#cgi.script_name#" class="form">

			<label for="host" class="form__label">
				Host:
			</label>
			<input id="host" type="text" name="host" value="127.0.0.1" class="form__input" />
			<button type="submit" class="form__button">
				Save
			</button>

		</form>

	</body>
	</html>

</cfoutput>
