<cfscript>

	param name="url.scanCursor" type="numeric" default=0;
	param name="url.scanPattern" type="string" default="*";

	if ( ! url.scanPattern.len() ) {

		url.scanPattern = "*";

	}

	results = application.scanner.scan( url.scanCursor, url.scanPattern );

</cfscript>
<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="./styles.css" />
	</head>
	<body class="p-list">

		<form method="get" action="#cgi.script_name#" class="form">

			<label for="scanPattern" class="form__label">Pattern:</label>
			<input id="scanPattern" type="text" name="scanPattern" value="#encodeForHtml( url.scanPattern )#" size="10" class="form__input" />
			<button type="submit" class="form__button">
				Scan
			</button>

		</form>

		<p class="pagination">
			<a href="#cgi.script_name#?scanPattern=#encodeForUrl( url.scanPattern )#&scanCursor=#encodeForUrl( results.cursor )#" target="list">Scan Next Page</a> &raquo;
		</p>

		<cfif results.keys.len()>

			<ul class="keys">
				<cfloop index="key" array="#results.keys#">
					
					<li class="keys__item">
						<a href="./detail.cfm?key=#encodeForUrl( key )#" target="detail" class="keys__link">#encodeForHtml( key )#</a>
					</li>

				</cfloop>
			</ul>

		<cfelse>

			<p>
				<em>No keys found at this scan offset.</em>
			</p>

		</cfif>

		<p class="pagination">
			<a href="#cgi.script_name#?scanPattern=#encodeForUrl( url.scanPattern )#&scanCursor=#encodeForUrl( results.cursor )#" target="list">Scan Next Page</a> &raquo;
		</p>

		<p class="reconfigure">
			<a href="./configure.cfm" target="_top" class="reconfigure__link">Reconfigure Scanner</a>
		</p>

	</body>
	</html>

</cfoutput>
