Terrarium: Habitat in Containers
================================

Terrarium is a small `docker-compose` based environment to easily run
a network of interconnected Habitat containers.

It also uses [tmuxinator](https://github.com/tmuxinator/tmuxinator) to
bring up the environment in a coordinated way, with access to each
supervisor.

Familiarity with both `docker-compose` and `tmux` / `tmuxinator` is
assumed. Though this repository is structured assuming you use all of
them together (because that's what I like to use), you can pick and
choose as you like.

# Container Layout

All containers isolated in the `terrarium_habitat` Docker
network. Each container is accessible at
`<CONTAINER_NAME>.habitat.dev` within this network.

As recommended, the Terrarium network has a "bastion" Supervisor that
runs no services, but with which all other Supervisors peer. It runs
in the `bastion` container.

Four other containers, named `alpha`, `beta`, `gamma`, and `delta` run
Supervisors peered with `bastion`. Initially, none of these
Supervisors are running services.

Another container, `console`, is in the same network, but is not
running a Supervisor. Instead, it runs an interactive shell. This
serves as your "workstation", from which you can interact with the
Supervisors using Habitat's remote control protocol. All containers
are pre-configured to use as shared secret, so you can simply add the
appropriate `--remote-sup` option to your `hab` commands to target the
desired Supervisor.

For example, to run `core/redis` on the `alpha` Supervisor, you would
execute the following from the `console` container:

```sh
hab svc load core/redis --remote-sup=alpha.habitat.dev
```

# Running

You'll need to either export an `IMAGE` environment variable, or
include it in an `.env` file for `docker-compose` to consume. This
variable should contain the image name/tag of an image with the
Habitat Supervisor in it, as you would get from `hab pkg export
docker`.

It doesn't really matter what Habitat package you may have exported,
since we just start up the bare Supervisor and don't load any
services.

To fire everything up:

```sh
make start
```

To stop the session:

```sh
make stop
```

This stops all the containers, captures their output, and then deletes them.

To go to a fresh state:

```sh
make clean
```
