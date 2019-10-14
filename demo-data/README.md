
# Demo Data Generation

The `generate.cfm` file is used to generate Redis commands in the file `commands.redis`. Once this file is populated, I pipe it into my Redis instance using the `redis-cli`:

```sh
redis-cli -h 127.0.0.1 < commands.redis 
```

## CAUTION

Note that the first command in the `commands.redis` file is `FLUSHDB`. **This will clear the entire Redis database**.
