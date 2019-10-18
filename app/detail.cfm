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
		<link rel="stylesheet" type="text/css" href="./styles.css?cacheBust=#application.cacheBust#" />
	</head>
	<body class="p-detail">

		<form method="get" action="#cgi.script_name#" target="detail" class="form">

			<label for="key-inpu" class="form__title">
				Key:
			</label>

			<div class="form__controls">

				<div class="form__control">
					<input
						id="key-inpu"
						type="text"
						name="key"
						value="#encodeForHtmlAttribute( url.key )#"
						class="form__input"
					/>
				</div>

				<div class="form__control form__control--action">
					<button type="submit" class="form__button">
						View
					</button>
				</div>

			</div>

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

			<!--- If there is no TYPE, it's becaus no key was found in Redis. --->
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
