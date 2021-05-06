# nginx-for-s3
A reverse proxy server for S3.

## Run:
```
docker build -t foo .
docker run \
  --name foo \
  --network host \
  -e S3_HOST=localhost \
  -e S3_PORT=9000 \
  -e S3_ACCESS_ID=user \
  -e S3_SECRET_KEY=password \
  -d foo
docker ps
docker exec -i -t foo /bin/sh
```
## Clean:
```
docker stop foo
docker ps -a
docker rm foo
docker images
docker rmi foo
```