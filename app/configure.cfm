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
			Configure Redis Key Scanner
		</title>

		<script type="text/javascript">

			// Since we're dealing with an old-school frameset, let's make sure that the
			// Configure page never shows up in one of the frames. Redirect at the top-
			// level if this page is framed.
			if ( window.self !== window.top ) {

				window.top.location = window.self.location;

			}

		</script>

		<link rel="stylesheet" type="text/css" href="./styles.css?cacheBust=#application.cacheBust#" />
	</head>
	<body class="p-configure">

		<h1 class="title">
			Configure Redis Key Scanner
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
