
# All from: kubernetes-the-hard-way

See https://github.com/kelseyhightower/
    
    
    Cluster network:               10.240.0.0/24     =     10.240.0.1 -> 10.240.0.254
    K8s network (cluster-cidr):    10.200.0.0/16     =     10.200.0.1 -> 10.200.255.254

    Controllers:        10.240.0.10 
                        10.240.0.11
                        10.240.0.12

    Workers:            10.240.0.20
                        10.240.0.21
                        10.240.0.22

    Service cluster IP range, set in controller (kube-api-server), should not overlap pods cidr.
    "A CIDR notation IP range from which to assign service cluster IPs. This must not overlap with 
      any IP ranges assigned to nodes for pods." 
       
        10.32.0.0/24      =     10.32.0.1 - 10.32.0.254
      
     Cluster cidr, set  workers and controllers (in kube-proxy, kube-controller-manager) 
    "The CIDR range of pods in the cluster. It is used to bridge traffic coming 
      from outside of the cluster. If not provided, no off-cluster bridging will be performed."
      
        10.200.0.0/16     =     10.200.0.1 - 10.200.255.254
        
        
     Cluster DNS: Fixed address used by kubeDNS add on:   
     
        10.32.0.1