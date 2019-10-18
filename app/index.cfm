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
			Redis Key Scanner
		</title>

		<link rel="stylesheet" type="text/css" href="./styles.css?cacheBust=#application.cacheBust#" />

		<script type="text/javascript">

			// In lieu of being able to use media-queries for FRAMESET orientation, we
			// are going to listen for the resize even, and then swap between ROWS and
			// COLS as the viewport drops below a given width.
			var orientation = "horizontal";
			var frameset = null;

			// NOTE: I don't seem to be able to execute a script tag after the frameset
			// for some reason. As such, I'll just wait until the window is loaded to
			// bind the resize event (so that the target frameset is accessible).
			window.addEventListener( "load", handleLoad );

			// ----------------------------------------------------------------------- //
			// ----------------------------------------------------------------------- //

			// I handle the window load event, and configure the resize event.
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
