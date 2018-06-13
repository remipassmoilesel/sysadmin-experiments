# Health check Kubernetes

Il est possible d'éxecuter des commandes de health check dans les conteneurs.

Exemple de déploiment avec health check HTTP:

    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: health-check-test-handling-kill-deployment
    spec:
      replicas: 5
      template:
        metadata:
          labels:
            run: health-check-test-handling-kill-deployment
        spec:
          containers:
          - name: health-check-test-handling-kill-deployment
            image: docker.bbuzcloud.com/health-check-test:1.0
            imagePullPolicy: Always
            ports:
            - containerPort: 80
            - containerPort: 8888
            - containerPort: 9999
            env:
            - name: HANDLE_KILL_SIGNAL
              value: "true"
    
            # Test d'état d'application éxécuté tout au long de la vie du pod
    
            livenessProbe:
              httpGet:
                path: /
                port: 8888
                scheme: HTTP
              initialDelaySeconds: 1
              periodSeconds: 1
              timeoutSeconds: 1
              failureThreshold: 2
              successThreshold: 1
    
            # Test d'état d'application éxécuté au démarrage du pod
    
            readinessProbe:
              failureThreshold: 2
              httpGet:
                path: /
                port: 80
                scheme: HTTP
              initialDelaySeconds: 1
              periodSeconds: 1
              timeoutSeconds: 1
              failureThreshold: 2
              successThreshold: 1
    
          imagePullSecrets:
              - name: regsecret