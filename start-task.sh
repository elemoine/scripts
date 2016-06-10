#!/bin/bash

for pod in $(kubectl get pods -l app=lma -o=name); do
  kubectl exec -it -c snap ${pod#pod/} -- snapctl task create -t /etc/snap/auto/task.json
done
