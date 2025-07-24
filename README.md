# books
Basic Blacklight app for searching the book collections in the M.E. Grenander Department of Special Collections & Archives at the University at Albany, SUNY

[https://archives.albany.edu/books](https://archives.albany.edu/books)

### For development

Run the app:
```
docker compose  up
```

Navigate to [http://localhost:3000/books](http://localhost:3000/books)

You should be able to edit code in real time.

### For deployment

Building the `books` image for production:
```
make build
```

Restarting the service:
```
make restart
```

#### For Windows

These commands don't work on Windows. For that you have to use the full build command:
```
$env:DOCKER_BUILDKIT=1; docker build --secret id=master_key,src=config/master.key -t books .
```

Running the image in the background:
```
docker compose -f docker-compose-prod.yml up -d
```
Navigate to [http://localhost:8082/books](http://localhost:8082/books)

To stop:
```
docker-compose down
```

### For a terminal

If you need another terminal:
```
docker exec -it books bash
```