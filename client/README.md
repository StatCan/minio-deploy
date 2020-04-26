## Web Identity

First you will need to run the client and then proceed to http://localhost to get the credentials you need.

```go
go run web-identity.go -config-ep $OPENID -cid $client -csec $SECRET
```

Add the host configuration to the mc cli.

```go
mc config host add minio http://127.0.0.1:9000 $ACCESSKEY $SECRETACCESSKEY $SESSIONTOKEN
```

Now you can read a bucket leveraging the new auth.

```
mc ls minio/shared
```
