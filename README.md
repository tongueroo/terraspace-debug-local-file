# Terraspace Project

This is a Terraspace project to help debug

* [Terraspace all up and Terraform local-file Resource](https://community.boltops.com/t/terraspace-all-up-and-terraform-local-file-resource/698/2)

## Reproduce the Bug

    $ terraspace all up
    Building one stack to build all stacks
    Building .terraspace-cache/us-west-2/dev/stacks/demo1
    Built in .terraspace-cache/us-west-2/dev/stacks/demo1
    Will run:
        terraspace up demo1 # batch 1
        terraspace up demo2 # batch 2
    Are you sure? (y/N) y
    Batch Run 1:
    Running: terraspace up demo1 Logs: log/up/demo1.log
    terraspace up demo1:  Changes to Outputs:
    terraspace up demo1:  Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
    Batch Run 2:
    Running: terraspace up demo2 Logs: log/up/demo2.log
    terraspace up demo2:  Changes to Outputs:
    terraspace up demo2:  Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
    Time took: 29s
    $

    $ tree .terraspace-cache/us-west-2/dev/stacks
    .terraspace-cache/us-west-2/dev/stacks
    ├── demo1
    │   ├── backend.tf
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── provider.tf
    │   └── variables.tf
    └── demo2
        ├── 1-base.auto.tfvars
        ├── backend.tf
        ├── foo2.bar
        ├── main.tf
        ├── outputs.tf
        ├── provider.tf
        └── variables.tf

    2 directories, 12 files
    $
