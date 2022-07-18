# Joe-test-project


## Infrastructure 

All Terraform files are packaged as follows:

```main.tf``` - Contains instance definition, and creates key pairs.  
```network.tf``` - Builds the AWS vpc.  
```variables.tf``` - AMI values, defaulted to the EC2 instance being built.  
```subnets.tf``` - Attached to gateway to allow public traffic to come through.  
```security.tf``` - Allows us to use SSH as terraform disables this.  

## Tagging Scheme

This project aims to implement a Semantic Version tagging Scheme in the form of:

```registry/image:Major.Minor.Patch.```

#### Using buildandpush.sh

Images can be created, tagged and pushed using 'buildandpush.sh' with the options [-Mmp] and the current three component number X.Y.Z. 

Example: './buildandpush.sh -m 1.1.1'. This will increment the version you provided if you're still working with localhost.

Valid identifiers are [0-9] only and hasn't been tested for [A-Za-z], arguments must be given in order to sucessfully execute.

### CI/CD Diagram

Contains an overview of a solution which catered to different deployments depending on the need. Most applications were to be deployed to our Kubernetes clusters but there are a few exceptions.

For services which needed to live on our Ubuntu servers for specific we deploy through Rundeck which is a run book automation system. 

In order to use it the engineer must ensure they have the following:

- A Dockerfile and a docker-compose file in the root of their repo. 
- A file named 'tendril.yml' which checks to see what pipeline to run, example below. 

```
pipeline:
type: rundeck-b1ebf02-c99a-47db-9180-802bd9306153
```
On commit this would only trigger once a PR has been pushed to main, where checks are performed and Jenkins executes a script to trigger the Rundeck API to execute a deployment. 

A default deployment would be to check the current status of the container and rebuild with the latest image. The runbooks use Ansible playbooks to do this under the hood. 

If no parameter is set Tendril will automatically deploy to our dev cluster. 