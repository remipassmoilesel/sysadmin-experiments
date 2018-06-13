# Dashboard

Vérifier si le dashboard est déployé:

    $ kubectl get pods --all-namespaces | grep dashboard
    
Sinon le créer (par exemple en post installation avec kubespray):

    $ kubectl create -f https://git.io/kube-dashboard
      
Pour scaler le déploiement:

    $ kubectl scale deployment --replicas 3 kubernetes-dashboard -n kube-system       
      
Pour le supprimer: 

    $ kubectl delete deployment kubernetes-dashboard --namespace=kube-system       

Pour déployer un service en nodeports:

    $ vim deployment.yaml
      ---
      kind: Service
      apiVersion: v1
      metadata:
        labels:
          k8s-app: kubernetes-dashboard
        name: kubernetes-dashboard-nodeports
        namespace: kube-system
      spec:
        type: NodePort
        ports:
        - port: 8080
          targetPort: 9090
          nodePort: 30000
        selector:
          k8s-app: kubernetes-dashboard

    $ kubectl apply -f deployment.yaml  