# Terraspace Project

This is a Terraspace project to help debug

* [Terraspace all up and Terraform local-file Resource](https://community.boltops.com/t/terraspace-all-up-and-terraform-local-file-resource/698/2)

## Works: simple terraspace up

* app/stacks/demo1: creates local file foo1.txt
* app/stacks/demo2: creates local file foo2.txt

app/stacks/demo1

    $ terraspace clean all -y
    $ terraspace up demo1 -y
    $ ls .terraspace-cache/us-west-2/dev/stacks/demo1/foo1.txt
    .terraspace-cache/us-west-2/dev/stacks/demo1/foo1.txt
    $

app/stacks/demo2

    $ terraspace clean all -y
    $ terraspace up demo1 -y
    $ ls .terraspace-cache/us-west-2/dev/stacks/demo2/foo2.txt
    .terraspace-cache/us-west-2/dev/stacks/demo2/foo2.txt
    $

## Reproduce the Issue: terraspace all

The issue is when `terraspace all up` vs `terraspace up` is used.

    $ terraspace clean all -y
    Removed .terraspace-cache
    Removed /tmp/terraspace
    Removing all files in log/
    Logs removed
    $ terraspace all up -y
    Building one stack to build all stacks
    Building .terraspace-cache/us-west-2/dev/stacks/demo1
    Built in .terraspace-cache/us-west-2/dev/stacks/demo1
    Running:
        terraspace up demo1 # batch 1
        terraspace up demo2 # batch 2
    Batch Run 1:
    Running: terraspace up demo1 Logs: log/up/demo1.log
    terraspace up demo1:  Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
    Batch Run 2:
    Running: terraspace up demo2 Logs: log/up/demo2.log
    terraspace up demo2:  Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
    Time took: 28s
    $ tree .terraspace-cache/us-west-2/dev/stacks/
    .terraspace-cache/us-west-2/dev/stacks/
    ├── demo1
    │   ├── backend.tf
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── provider.tf
    │   └── variables.tf
    └── demo2
        ├── 1-base.auto.tfvars
        ├── backend.tf
        ├── foo2.txt
        ├── main.tf
        ├── outputs.tf
        ├── provider.tf
        └── variables.tf

    2 directories, 12 files
    $

Notice how `foo1.txt` is missing.

## Why?

The reason that foo1.txt is missing is because between terraspace batch up run, the .terraspace-cache files are cleared. One of the reasons is that outputs are recalculated for dependencies and the implementation clears out files and recomputes the output values for the tfvars.  Unsure if can make this recalculation smarter.

## Remove or Workaround Issue

There's a `build.clean_cache` config that can be set to `false`	to disable the clean step between the batch runs.

* [Terraspace Docs: Config Reference](https://terraspace.cloud/docs/config/reference/)

[config/app.rb](config/app.rb)

```ruby
Terraspace.configure do |config|
  config.logger.level = :info
  config.test_framework = "rspec"

  # Setting `clean_cache = false` disables cleaning the .terraspace-cache between runs.
  # This allows terraspace all up to work where there are modules that generate local files.
  # Wondering if relying on generated local files from different stacks is an good, okay, or bad thing.
  # config.build.clean_cache = false
end
```