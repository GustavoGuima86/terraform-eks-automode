## Terraform Eks Automode example

This is a simple example for the implementation of Karpenter in eks using Terraform as a cloud provider


### Main problem

When trying to deploy auto mode + managed or first deploy Auto mode and then Managed, we face the following error in the managed node 

```container runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized```

It doesn't recognized the VPC CNI implemented by Auto mode either let us install the plugin VPC CNI by ourself.