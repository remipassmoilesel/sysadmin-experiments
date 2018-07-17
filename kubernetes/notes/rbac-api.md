# Api RBAC

Cluster role cluste-admin:

    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      annotations:
        rbac.authorization.kubernetes.io/autoupdate: "true"
      creationTimestamp: 2018-07-07T16:01:58Z
      labels:
        kubernetes.io/bootstrapping: rbac-defaults
      name: cluster-admin
      resourceVersion: "37"
      selfLink: /apis/rbac.authorization.k8s.io/v1/clusterroles/cluster-admin
      uid: 13d4f13f-81ff-11e8-96f3-0238b8f5607e
    rules:
    - apiGroups:
      - '*'
      resources:
      - '*'
      verbs:
      - '*'
    - nonResourceURLs:
      - '*'
      verbs:
      - '*'
