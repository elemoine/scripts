#!/bin/bash

if [[ -z ${IMAGES} ]]; then
    IMAGES="mcp/influxdb mcp/snap mcp/hindsight"
fi

if [[ -z ${NODES} ]]; then
    NODES="node2 node3"
fi

for img in $IMAGES; do
    archive="${img#mcp/}.tar"
    rm -f ${archive}
    docker save -o ${archive} ${img}
    for node in $NODES; do
        scp ${archive} ${node}:/tmp/
        ssh ${node} docker load -i /tmp/${archive}
        ssh ${node} rm /tmp/${archive}
    done
done
