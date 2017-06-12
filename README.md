# ws-mongo-demo

#### A instance of MongoDB used in the [ws-dev-docker-example](https://github.com/WillStreeter/ws-dev-docker-example).


## Architecture:
This repository is part of a larger effort to expound on the strategies and approaches delineated in the article
[Practical Web Development and Architecture](https://medium.com/p/26a37d04c10f/edit). While an explicit repository for
MongoDB is currently not necessary, it will eventually become so when default information including,
database name, user name, and password becomes specific and  a process for importing an initial set of collections needs
to be established immediately after MongoDB is running.

When a virtual hosting container with **docker-compose** is established with [ws-dev-docker-example](https://github.com/WillStreeter/ws-dev-docker-example),
the docker-compose service name 'mongo' becomes the host-name with which [ws-node-demo](https://github.com/WillStreeter/ws-node-demo)
will establish a connection.

```
  // with a docker-compose implementation
    mongodb://mongo:27017/ws-demo


  // rather than  the localhost address
    mongodb://127.0.0.1:27017/ws-demo
```
