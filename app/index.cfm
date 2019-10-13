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

		<script type="text/javascript">

			var orientation = "horizontal";
			var frameset = null;

			window.addEventListener( "load", handleLoad );

			// ----------------------------------------------------------------------- //
			// ----------------------------------------------------------------------- //

			function handleLoad() {

				frameset = document.querySelector( "frameset" );
				handleResize();

				window.addEventListener( "resize", handleResize );

			}


			// I orient the frameset based on the viewport width.
			function handleResize() {

				var width = window.innerWidth;

				if ( ( width < 675 ) && ( orientation === "horizontal" ) ) {

					frameset.setAttribute( "rows", "50%,50%" );
					frameset.setAttribute( "cols", null );
					orientation = "vertical";

				}

				if ( ( width >= 675 ) && ( orientation === "vertical" ) ) {

					frameset.setAttribute( "cols", "50%,50%" );
					frameset.setAttribute( "rows", null );
					orientation = "horizontal";

				}

			}

		</script>
	</head>
	<frameset cols="50%,50%">
		<frame name="list" src="./list.cfm"></frame>
		<frame name="detail" src="./detail.cfm"></frame>
	</frameset>
	</html>

</cfoutput>
