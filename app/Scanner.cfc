component
	output = false
	hint = "I provide scan-based accessed to a Redis database."
	{

	/**
	* I initialize the Scanner with the given Java Loader.
	* 
	* @javaLoaderForJedis I am the JavaLoader for the Jedis library.
	*/
	public any function init( required any javaLoaderForJedis ) {

		variables.loader = javaLoaderForJedis;

		// These properties will only be made available when the Scanner is configured to
		// inspect a given Redis host.
		variables.host = "";
		variables.pool = "";

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I configure the Scanner to inspect the given Redis host.
	* 
	* @newHost I am the Redis host to connect to.
	*/
	public void function configure( required string newHost ) {

		// If there is an existing connection pool, close it.
		if ( isConfigured() ) {

			variables.pool.close();
			variables.pool = "";
			variables.host = "";

		}

		var config = loader
			.create( "redis.clients.jedis.JedisPoolConfig" )
			.init()
		;
		var pool = loader
			.create( "redis.clients.jedis.JedisPool" )
			.init( config, newHost )
		;

		variables.pool = pool;
		variables.host = newHost;

	}


	/**
	* I get the data and meta-data stored at the given key.
	*/
	public struct function inspect( required string key ) {

		assertIsConfigured();

		var results = {
			key: key,
			type: "none",
			ttl: "none",
			value: ""
		};

		results.type = withRedis(
			( redis ) => {

				return( redis.type( key ) );

			}
		);

		// If the key doesn't exist, there's no point in trying to access the rest of
		// key meta-data.
		if ( results.type == "none" ) {

			return( results );

		}

		results.ttl = formatTTL(
			withRedis(
				( redis ) => {

					return( redis.ttl( key ) );

				}
			)
		);

		results.value = getValueByType( key, results.type );

		return( results );

	}


	/**
	* I determine if the Scanner has been configured for a Redis host.
	*/
	public boolean function isConfigured() {

		return( ! isSimpleValue( pool ) );

	}


	/**
	* I scan over the Redis keys, using the given cursor and pattern.
	* 
	* NOTE: The pattern is applied to the keys AFTER they have been scanned. As such,
	* it's possible to use a pattern that returns zero results prior to the end of a
	* full iteration of the Redis database.
	* 
	* @scanCursor I am the cursor performing the iteration.
	* @scanPattern I am the post-scan filter to apply to the result-set.
	* @scanCount I am the number of keys to scan in one operation.
	*/
	public struct function scan(
		required numeric scanCursor,
		required string scanPattern,
		numeric scanCount = 100
		) {

		assertIsConfigured();

		var scanParams = loader
			.create( "redis.clients.jedis.ScanParams" )
			.init()
			.match( scanPattern )
			.count( scanCount )
		;

		var results = withRedis(
			( redis ) => {

				return( redis.scan( scanCursor, scanParams ) );

			}
		);

		return({
			cursor: results.getCursor(),
			keys: results.getResult()
		});

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I assert that the Scanner is configured; and, throw an error if not.
	*/
	private void function assertIsConfigured() {

		if ( ! isConfigured() ) {

			throwNotConfiguredError();

		}

	}


	/**
	* I format the given TTL value to make it more human-readable.
	* 
	* @ttl I am the TTL in seconds being formatted.
	*/
	private string function formatTTL( required numeric ttl ) {

		if ( ttl < 0 ) {

			return( "none" );

		}

		if ( ttl < 60 ) {

			return( ttl & " seconds" );

		}

		var ttlInMinutes = ( ttl / 60 );

		if ( ttlInMinutes < 60 ) {

			return( numberFormat( ttlInMinutes, "0.0" ) & " minutes" );

		}

		var ttlInHours = ( ttlInMinutes / 60 );

		if ( ttlInHours < 24 ) {

			return( numberFormat( ttlInMinutes, "0.0" ) & " hours" );

		}

		var ttlInDays = ( ttlInHours / 24 );

		if ( ttlInDays < 28 ) {

			return( numberFormat( ttlInDays, "0.0" ) & " days" );

		}

		var ttlInWeeks = ( ttlInDays / 7 );

		return( numberFormat( ttlInWeeks, "0.0" ) & " weeks" );

	}


	/**
	* I get the Redis key value for a key of the given type.
	* 
	* @key I am the key being read.
	* @type I am the data-type stored at the given key.
	*/
	private any function getValueByType(
		required string key,
		required string type
		) {

		var value = withRedis(
			( redis ) => {

				switch ( type ) {
					case "hash":
						return( redis.hgetAll( key ) );
					break;
					case "list":
						return( redis.lrange( key, 0, -1 ) );
					break;
					case "set":
						return( redis.smembers( key ) );
					break;
					case "string":
						return( redis.get( key ) );
					break;
					case "zset":
						return( redis.zrange( key, 0, -1 ) );
					break;
					default:
						return( "Redis type [#type#] not supported by Scanner." );
					break;
				}

			}
		);

		return( isNull( value ) ? "" : value );

	}


	/**
	* I throw a Not Configured error.
	*/
	private void function throwNotConfiguredError() {

		throw(
			type = "RedisScannerNotConfigured",
			message = "Redis Scanner not yet configured.",
			detail = "Before the Redis Scanner can be used, it must be configured using the .configure() method."
		);

	}


	/**
	* I invoke the given Callback with an instance of a Redis connection from the Jedis
	* connection pool. The value returned by the Callback is passed-back up to the
	* calling context. This removes the need to manage the connection in the calling
	* context.
	* 
	* @callback I am a Function that is invoked with an instance of a Redis connection.
	*/
	private any function withRedis( required function callback ) {

		try {

			var redis = pool.getResource();

			return( callback( redis ) );

		} finally {

			redis?.close();

		}

	}

}
