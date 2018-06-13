#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/09-dns-addon.md

kubectl run nginx --image=nginx --port=80 --replicas=3
kubectl get pods -o wide

kubectl expose deployment nginx --type NodePort

NODE_PORT=$(kubectl get svc nginx --output=jsonpath='{range .spec.ports[0]}{.nodePort}')

gcloud compute firewall-rules create kubernetes-nginx-service \
  --allow=tcp:${NODE_PORT} \
  --network kubernetes-the-hard-way

echo "Waiting 10s ..."
sleep 10

NODE_PUBLIC_IP=$(gcloud compute instances describe worker0 \
  --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')

echo "curl http://${NODE_PUBLIC_IP}:${NODE_PORT}"
curl http://${NODE_PUBLIC_IP}:${NODE_PORT}
