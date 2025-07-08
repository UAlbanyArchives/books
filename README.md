# books
Basic Blacklight app for searching the book collections in the M.E. Grenander Department of Special Collections & Archives at the University at Albany, SUNY

[https://archives.albany.edu/books](https://archives.albany.edu/books)

### For development

Run the app:
```
docker-compose -f docker-compose-dev.yml up
```

Navigate to [http://localhost:3000/books](http://localhost:3000/books)

You should be able to edit code in real time.

When you're done:
```
docker-compose down
```

### For deployment

Building the `books` image locally:
```
DOCKER_BUILDKIT=1 docker build --secret id=master_key,src=config/master.key -t books .
```
On Windows
```
$env:DOCKER_BUILDKIT=1; docker build --secret id=master_key,src=config/master.key -t books .
```

Running the image in the background:
```
docker-compose up -d
```
Navigate to [http://localhost:8082/books](http://localhost:8082/books)

&#8594; In production, this should be set up to run as a service

To stop:
```
docker-compose down
```

### For a terminal

If you need another terminal:
```
docker exec -it books bash
```