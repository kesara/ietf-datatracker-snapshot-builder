# IETF datatracker database snapshot builder

![main branch build status](https://api.travis-ci.com/kesara/ietf-datatracker-snapshot-builder.svg?branch=main)

This repository builds and uploads latest database snapshot for
[IETF Datatracker](https://datatracker.ietf.org/).

This perfoms:
 * Checkout latest trunk for datatracker.
 * Set up the database
 * Run migrations
 * Creates a data snapshot
 * Upload data snapshot _(not functioning)_
