#!/bin/bash -ex

cat > /tmp/r-pod << EOF
apiVersion: v1
kind: Pod
metadata:
  name: registry
  labels:
    app: registry
spec:
  containers:
    - name: registry
      image: registry:2
      env:
      imagePullPolicy: Always
      ports:
        - containerPort: 5000
          hostPort: 5000
EOF

cat > /tmp/r-service << EOF
kind: "Service"
apiVersion: "v1"
metadata:
  name: "registry"
spec:
  selector:
    app: "registry"
  ports:
    -
      protocol: "TCP"
      port: 5000
      targetPort: 5000
      nodePort: 31500
  type: "NodePort"
EOF

kubectl create -f /tmp/r-pod
kubectl create -f /tmp/r-service
