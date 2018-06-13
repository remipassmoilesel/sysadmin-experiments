#!/usr/bin/env bash

# see https://github.com/remipassmoilesel/kubernetes-the-hard-way/blob/master/docs/08-network.md

export ROUTES=$(kubectl get nodes \
  --output=jsonpath='{range .items[*]}{.status.addresses[?(@.type=="InternalIP")].address} {.spec.podCIDR} {"\n"}{end}')

while read -r line; do
    echo line= "$line"
    INTERNAL_IP=$(echo $line | cut -d' ' -f1)
    DEST_RANGE=$(echo $line | cut -d' ' -f2)
    DEST_RANGE_NAME=kubernetes-route-${DEST_RANGE////-}
    DEST_RANGE_NAME=${DEST_RANGE_NAME//./-}

    echo internal_ip=$INTERNAL_IP dest_range=$DEST_RANGE dest_range_name=$DEST_RANGE_NAME

    gcloud compute routes create $DEST_RANGE_NAME \
      --network kubernetes-the-hard-way \
      --next-hop-address $INTERNAL_IP \
      --destination-range $DEST_RANGE

done <<< "$ROUTES"