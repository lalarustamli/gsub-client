# The Kisi Backend Code Challenge

This repository can be used as a starting point for the Kisi Backend Code Challenge. Feel free to replace this `README.md` with your own when you submit your solution.

This repository contains:
- A bare-bones Rails 6 API app with a `Gemfile` that contains the neccessary libraries for the project.
- A configured adapter ([lib/active_job/queue_adapters/pubsub_adapter.rb](lib/active_job/queue_adapters/pubsub_adapter.rb)) to enqueue jobs. Use as a starting point for your own code.
- A rake task ([lib/tasks/worker.rake](lib/tasks/worker.rake)) to launch the worker process. Use as a starting point for your own code.
- A class ([lib/pubsub.rb](lib/pubsub.rb)) that wraps the GCP Pub/Sub client. Use as as a starting point for your own code.
- A [Dockerfile](Dockerfile) and a [docker-compose.yml](docker-compose.yml) configured to spin up necessary services (web server, worker, pub/sub emulator).

To start all services, make sure you have [Docker](https://www.docker.com/products/docker-desktop/) installed and run:
```
$ docker compose up
```

To restart the worker, i.e. after a code change:
```
$ docker compose restart worker
```

To start a console:
```
$ docker compose run --rm web bin/rails console
```

If you run docker with a VM (e.g. Docker Desktop for Mac) we recommend you allocate at least 2GB Memory

## Changes

1. The configured adapter([lib/active_job/queue_adapters/pubsub_adapter.rb](lib/active_job/queue_adapters/pubsub_adapter.rb)) is able to enqueue and enqueue at given timestamp to Google Pubsub.
2. A subscriber task ([lib/tasks/subscriber.rake](lib/tasks/subscriber.rake)) listens to Google Pub/Sub and executes relevant jobs.
3. Some example jobs are provided in ([jobs](app/jobs/hello_kisi_job.rb)) that gets retried at most 2 times, 5 minutes apart. If failed, forwards to `morgue`. The approach leads to `at_least_once`.

How to run:
1. Run all services in Docker
```
$ docker compose up
```
2. Create some load
```
$ docker compose run --rm web bin/rails console
HelloKisiJob.set(wait: 5.seconds).perform_later
HelloKisiJob.set(wait: 1.seconds).perform_later
HelloKisiJob.perform_later
...
```