#!/bin/bash

ssh -f -L localhost:3333:localhost:5432 aracar sleep 10
psql -h localhost -p 3333 -U davical_app -d davical
