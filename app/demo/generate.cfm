<cfscript>
	
	loop times = 425 {

		switch ( randRange( 0, 4 ) ) {
			case 0:
				key = "rand:string:#createUUID().lcase()#:#randRange( 0, 100 )#";
				echo( "SET #key# ""random string value value""<br />" );
				echo( "EXPIRE #key# #randRange( 1, 999999 )#<br />" );
			break;
			case 1:
				key = "rand:zset:#createUUID().lcase()#:#randRange( 0, 100 )#";
				echo( "ZADD #key# 1 foo 2 bar 2 baz 2 bob 2 boop<br />" );
			break;
			case 2:
				key = "rand:set:#createUUID().lcase()#:#randRange( 0, 100 )#";
				echo( "SADD #key# foo bar baz bob boop<br />" );
				echo( "EXPIRE #key# #randRange( 1, 999999 )#<br />" );
			break;
			case 3:
				key = "rand:hash:#createUUID().lcase()#:#randRange( 0, 100 )#";
				echo( "HMSET #key# a 1 b 2 c 3 d 4<br />" );
				echo( "EXPIRE #key# #randRange( 1, 999999 )#<br />" );
			break;
			case 4:
				key = "rand:list:#createUUID().lcase()#:#randRange( 0, 100 )#";
				echo( "RPUSH #key# what the heck is that<br />" );
			break;
		}

	}

</cfscript>
