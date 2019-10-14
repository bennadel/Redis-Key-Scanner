
# Redis Key Scanner Using Lucee CFML And Jedis

by [Ben Nadel][bennadel]

Partly as a learning experiment, partly because I have an actual need to inspect a Redis database, I built a super light-weight Redis key scanner using [Lucee CFML][lucee] 5.2.8.50 and [Jedis][jedis] 2.9.3. All it does is provide a GUI (Graphical User Interface) for iterating the keys in the configured Redis database; and then, viewing those keys along with their Type, TTL (Time To Live), and mapped Value.

<p align="center">
	<a href="./README-screenshot.png?raw=true" target="_blank"
		><img
			src="./README-screenshot.png?raw=true"
			title="Screenshot of Redis Key Scanner running via CommandBox."
			width="600"
	/></a>
</p>

### Demo Data

For the Demo, I **flushed** and **populated** my local Redis instance using [./demo-data](./demo-data).

[bennadel]: https://www.bennadel.com "The blog of Ben Nadel"
[lucee]: https://lucee.org "Light-weight dynamic CFML scripting language"
[jedis]: https://github.com/xetorthio/jedis "GitHub: A blazingly small and sane redis java client"
