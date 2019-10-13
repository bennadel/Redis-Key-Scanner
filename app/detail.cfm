<cfscript>

	param name="url.key" type="string" default="";

	if ( url.key.len() ) {

		results = application.scanner.inspect( url.key );

	}

</cfscript>
<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="./styles.css" />
	</head>
	<body class="p-detail">

		<form method="get" action="#cgi.script_name#" class="form">

			<label for="key" class="form__label">Key:</label>
			<input id="key" type="text" name="key" value="#encodeForHtml( url.key )#" class="form__input" />
			<button type="submit" class="form__button">
				View
			</button>

		</form>

		<cfif url.key.len()>
			
			<div class="datum">
				<div class="datum__label">
					Key:
				</div>
				<div class="datum__value">
					#encodeForHtml( results.key )#
				</div>
			</div>

			<div class="datum">
				<div class="datum__label">
					Type:
				</div>
				<div class="datum__value">
					<cfif ( results.type eq "none" )>
						<span class="datum__warning">
							<strong>Caution</strong>: None. This key does not exist.
						</span>
					<cfelse>
						#encodeForHtml( results.type.ucfirst() )#
					</cfif>
				</div>
			</div>

			<cfif ( results.type neq "none" )>

				<div class="datum">
					<div class="datum__label">
						TTL:
					</div>
					<div class="datum__value">
						<cfif ( results.ttl eq "none" )>
							<span class="datum__warning">
								<strong>Caution</strong>: No TTL set. This key will be here forever.
							</span>
						<cfelse>
							#encodeForHtml( results.ttl )#
						</cfif>
					</div>
				</div>

				<div class="datum">
					<div class="datum__label">
						Value:
					</div>
					<div class="datum__value">
						<cfdump var="#results.value#" format="simple" />
					</div>
				</div>

			</cfif>

		<cfelse>

			<p>
				Select a key to view the details.
			</p>

		</cfif>

	</body>
	</html>

</cfoutput>
