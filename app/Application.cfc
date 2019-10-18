component
	output = false
	hint = "I define the application settings and event handlers."
	{

	// Configure the application runtime.
	this.name = "RedisKeyScanner";
	this.applicationTimeout = createTimeSpan( 0, 8, 0, 0 );
	this.sessionManagement = false;

	// Setup the mappings for our path evaluation.
	this.webrootDir = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings = {
		"/": this.webrootDir,
		"/javaloader": "#this.webrootDir#vendor/JavaLoader/javaloader/",
		"/JavaLoaderFactory": "#this.webrootDir#vendor/JavaLoaderFactory/",
		"/jedis": "#this.webrootDir#vendor/jedis-2.9.3/"
	};

	// ---
	// EVENT METHODS.
	// ---

	/**
	* I get called once when the application is being initialized.
	*/
	public boolean function onApplicationStart() {

		// Let's store a new cache-bust value when the application boots-up. This can be
		// used to cache-bust URLs for static assets (such as CSS files).
		application.cacheBust = getTickCount();

		var javaLoaderFactory = new JavaLoaderFactory.JavaLoaderFactory();

		application.scanner = new Scanner(
			javaLoaderFactory.getJavaLoader([
				expandPath( "/jedis/commons-pool2-2.4.3.jar" ),
				expandPath( "/jedis/jedis-2.9.3.jar" ),
				expandPath( "/jedis/slf4j-api-1.7.22.jar" )
			])
		);

		return( true );

	}


	/**
	* I get called once when a request is being initialized.
	*/
	public void function onRequestStart() {

		// Check to see if we are restarting the application (this is used during
		// development to reset the internal state of the application).
		if ( url.keyExists( "init" ) ) {

			applicationStop();
			sleep( 100 );
			location( url = cgi.script_name );

		}

	}

}
