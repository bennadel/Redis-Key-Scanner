<cfscript>

	param name="url.scanCursor" type="numeric" default=0;
	param name="url.scanPatternInclude" type="string" default="";
	param name="url.scanPatternExclude" type="string" default="";

	results = application.scanner.scan(
		url.scanCursor,
		url.scanPatternInclude,
		url.scanPatternExclude
	);

</cfscript>
<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="./styles.css?cacheBust=#application.cacheBust#" />
	</head>
	<body class="p-list">

		<form method="get" action="#cgi.script_name#" class="form">

			<div class="form__title">
				Patterns (RegEx):
			</div>

			<div class="form__controls">

				<div class="form__control">
					<label for="include-keys-input" class="form__label">
						Include Keys
					</label>
					<input
						id="include-keys-input"
						type="text"
						name="scanPatternInclude"
						value="#encodeForHtmlAttribute( url.scanPatternInclude )#"
						class="form__input"
					/>
				</div>

				<div class="form__control">
					<label for="exclude-keys-input" class="form__label">
						Exclude Keys
					</label>
					<input
						id="exclude-keys-input"
						type="text"
						name="scanPatternExclude"
						value="#encodeForHtmlAttribute( url.scanPatternExclude )#"
						class="form__input"
					/>
				</div>

				<div class="form__control form__control--action">
					<button type="submit" class="form__button">
						Scan
					</button>
				</div>

			</div>

		</form>

		<p class="pagination">
			<a href="#cgi.script_name#?scanPatternInclude=#encodeForUrl( url.scanPatternInclude )#&scanPatternExclude=#encodeForUrl( url.scanPatternExclude )#&scanCursor=#encodeForUrl( results.cursor )#" target="list">Scan Next Page</a> &raquo;
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
				<em>No keys found at this scan offset ( #encodeForHtml( url.scanCursor )# ).</em>
			</p>

		</cfif>

		<p class="pagination">
			<a href="#cgi.script_name#?scanPatternInclude=#encodeForUrl( url.scanPatternInclude )#&scanPatternExclude=#encodeForUrl( url.scanPatternExclude )#&scanCursor=#encodeForUrl( results.cursor )#" target="list">Scan Next Page</a> &raquo;
		</p>

		<p class="reconfigure">
			<a href="./configure.cfm" target="_top" class="reconfigure__link">Reconfigure Scanner</a>
		</p>

	</body>
	</html>

</cfoutput>
