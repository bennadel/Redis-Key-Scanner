<cfscript>

	commandsFile = "./commands.redis";

	cfsavecontent( variable = "commands" ) {

		echoLine( "FLUSHDB" );
		echoLine();

		echoLine( "SETEX ben:demo:key1 10000 3.1415" );
		echoLine( "SET ben:demo:key2 'hello world'" );
		echoLine( "SET ben:demo:key3 'woot woot'" );
		echoLine();

		echoLine( "SADD ben:demo:key4 cool awesome wicked thrilla nifty sweet" );
		echoLine( "EXPIRE ben:demo:key4 1234" );
		echoLine();

		echoLine( "SADD ben:demo:key5 libby liz ellie elizabeth lizzy" );
		echoLine();

		echoLine( "ZADD ben:demo:key6 1 bill 1 billy 27 william 39 willie 24 will" );
		echoLine( "EXPIRE ben:demo:key6 9998998" );
		echoLine();

		echoLine( "RPUSH ben:demo:key7 aaa bbb ccc ddd eee fff ggg hhh" );
		echoLine( "EXPIRE ben:demo:key7 600" );
		echoLine();

		echoLine( "HMSET ben:demo:key8 id 1 name ben role admin" );
		echoLine( "HMSET ben:demo:key9 id 2 name libby role manager" );
		echoLine( "EXPIRE ben:demo:key9 9998990" );
		echoLine();

		// Let's also put a bunch of random data in the database, some with TTL values,
		// some that will live forever.
		loop times = 425 {

			switch ( randRange( 0, 4 ) ) {
				case 0:
					key = "rand:string:#createUUID().lcase()#:#randRange( 0, 100 )#";
					echoLine( "SET #key# ""random string value value""" );
					echoLine( "EXPIRE #key# #randRange( 1, 999999 )#" );
				break;
				case 1:
					key = "rand:zset:#createUUID().lcase()#:#randRange( 0, 100 )#";
					echoLine( "ZADD #key# 1 foo 2 bar 2 baz 2 bob 2 boop" );
				break;
				case 2:
					key = "rand:set:#createUUID().lcase()#:#randRange( 0, 100 )#";
					echoLine( "SADD #key# foo bar baz bob boop" );
					echoLine( "EXPIRE #key# #randRange( 1, 999999 )#" );
				break;
				case 3:
					key = "rand:hash:#createUUID().lcase()#:#randRange( 0, 100 )#";
					echoLine( "HMSET #key# a 1 b 2 c 3 d 4" );
					echoLine( "EXPIRE #key# #randRange( 1, 999999 )#" );
				break;
				case 4:
					key = "rand:list:#createUUID().lcase()#:#randRange( 0, 100 )#";
					echoLine( "RPUSH #key# what the heck is that" );
				break;
			}

		}

	}

	fileWrite( commandsFile, commands );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I echo the given value, followed by a newline character.
	* 
	* @value I am the value being echoed.
	*/
	public void function echoLine( string value = "" ) {

		echo( value & chr( 10 ) );

	}

</cfscript>
