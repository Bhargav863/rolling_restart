# rolling_restart
This repo is used to test the automation for rolling restart of deployments in a kubernetes cluster.

**Goal**
You have to create a robust, non-interactive jenkins job that restarts all deployments in a kubernetes namespace and verify they come back healthy.

**1) Create kubernetes service account and RBAC**
  
   * service_account.yaml --> A service account is a type of non-human account that, in Kubernetes, provides a distinct identity in a Kubernetes cluster. You can access the kubernetes api-server using this service account.
     ```
     kubectl apply -f service_account.yaml
     ```

**2) Create a role for the service account with the access that service account needs to have**

   * jenkins_sa_role.yaml --> Defines permission within the namespace.
      ```
      kubectl apply -f jenkins_sa_role.yaml
      ```

**3) Bind the role with service account that the service account can get the permission to update/delete the pods in the namespace**
  
   * rolebinding.yaml --> It will bind the role to the service account.
     ```
     kubectl apply -f rolebinding.yaml
     ```

     

