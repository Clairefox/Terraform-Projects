# Carla's Terraform Projects

## Table of Contents

1. <a href="#Project-Requirements">Project Requirements</a>
    1. <a href="#Extra-Credit">Extra Credit</a>
2. <a href="#Built-With">Built With</a>
3. <a href="#Using-This-Project">Using This Project</a>
    1. <a href="#Prerequisites">Prerequisites</a>
    2. <a href="#Setup-and-Use">Setup and Use</a>
    3. <a href="#Module-Inputs">Module Inputs</a>
    4. <a href="#Design-Notes">Design Notes</a>
4. <a href="#Contributing">Contributing</a>
5. <a href="#License">License</a>
6. <a href="#Contact">Contact</a>
7. <a href="#Acknowledgements">Acknowledgements</a>

## Project Requirements

Using Terraform v12, build a module meant to deploy a web application that supports the following design:
- It must include a VPC which enables future growth / scale
- It must include both a public and private subnet - where the private subnet is used for compute and the public is used for the load balancers
- Assuming that end-users only contact the load balancers and the underlying instances are accessed for management purposes, design a security group scheme which supports the minimal set of ports required for communication
- The AWS generated load balancer hostname will be used for requests to the public facing web application
- The instances in the ASG
    - must contain both a root volume to store the application / services
    - must contain a secondary volume meant to store any log data bound for /var/log
    - must include a web server of your choice
- Your completed module should include a README which explains the module inputs and any important design decisions you made which may assist in evaluation
- *All requirements for configuring the operating system should be defined in the launch configuration and/or the user data script (no external config tools like chef, puppet, etc.)*
- *Your module should not be tightly coupled to your AWS account - it should be designed so that it can be deployed to any arbitrary AWS account*

### Extra Credit

- You must ensure that all data is encrypted at rest
- Ideally, you should design these web servers so they can be managed without logging in with the root key
- We should have some sort of alarm mechanism that indicates when the application is experiencing any issues
- Configure the autoscaling group to automatically add and remove nodes based on load
- You should assume that this web server may receive high volumes of web traffic, thus you should appropriately manage the storage / growth of logs

## Built With

- [Markdown](https://www.markdownguide.org/basic-syntax/#reference-style-links)
- [Terraform](https://www.terraform.io/)
- [Bash](https://www.gnu.org/software/bash/)

## Using This Project

### Prerequisites

- [Download and Install Terraform](https://www.terraform.io/downloads)
- [Download and Install Docker Desktop](https://docs.docker.com/docker-hub/) - to test app locally, since we're using AWS for the production site
- [Download and Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

### Setup and Use

1. Clone this repository to local.
2. Create site code and store in "site" sub-folder.
    1. Can test with Terraform and Docker locally here to verify it works as expected (Steps not included).
3. In AWS, create a user for use by terraform. [Can follow these steps](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started.html)
4. Save the user's credentials as environment variables on the system. (There should be a way to dynamically pull these creds securely though...)
5. Update terraform variables to use appropriate AWS values for your environment. 
    1. [Steps here on how to find a windows ami](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/finding-an-ami.html)
6. Initialize Terraform locally with "terraform init" in the top-level directory of "main.tf"
7. Validate no issues with "terraform plan". Resolve issues as needed.
8. Deploy application to AWS with "terraform apply".
    1. Wait for complete message and then verify web application is deployed successfully by visiting it's site, running any tests as needed, and verifying health checks.
9. When application needs to come down, use "terraform destory" to turn off the AWS resources.

### Module Inputs

- The end user site in this demo does not have any inputs that a user can submit data with.
- All configurations are edited in their respective variables.tf file. No other file should need to be edited except for the web application specific files in the subfolder "site".
    - general variables are on the same level as the main.tf
    - resource specific variables are defined in the respective resources subfolder

- Top Level Main.tf and Variables.tf
    - These files control how the terraform script should run and calls the child resources/modules as needed.
- AutoScaling Groups
    - These inputs describe the min/max/desired number of servers to be used.
- Instances
    - These inputs describe the instances connection information: IPs, subnets, SSH info, etc.
- Launch Configurations
    - These inputs describe the instance types as well as the web application boot script.
- Load Balancers
    - These inputs describe the loadbalancers that direct traffic to the instances, as well as health check parameters to verify traffic is flowing as intended.
- Site
    - These inputs are related to what's required to run the web application, including code related to the application.

### Design Notes

- Changes to Original Code
    - A big thing we're all taught in coding is to not reinvent the wheel as much as possible, reuse what you can, and to make sure that you provide credit to your sources. I'm not sure if it's allowed for a take-home assessment, but the majority of this code came from the AWS Terraform Example Repo (linked in Acknowledgements). I've updated this code for the assessment requirements as much as I was able, to resolve issues when running "terraform plan", and for ease of reading.
    - Issues resolved to run "terraform plan" successfully on latest version of terraform:
        - Edited tags blocks missing "=" in all non-"variable.tf" files in sub-folders, removing where no longer needed, and fixed where possible.
        - Removed declaration {} blocks where no longer needed.
        - Resolved type issue on "site\variables.tf" file for availability zones to "list(string)" and formatted properly.
    - This code uses linux containers to deploy the web app. To run using windows boxes, a different application will need to be create under the "site" folder that uses nginx or some other engine rather than bastion.
    - As is, it will "terraform plan" successfully on my workstation with my AWS account. I did not run "terraform apply" because $$$.
- Not Using Terraform Cloud to Store Remote State
    - Ideally, a git repository would be the one truth of the configurations of the project. It would include secured branches requiring code review and approvals for pull requests into the "production" branch. DEV/TEST/QA (Or Epics/Features/Hotfixes) branches would be created as needed for new features and hotfixes and have GitHub actions on a self-hosted runner kicking off the deploys and testing. Once passed, then the final approved pull request into PROD would have its GitHub action to deploy to the live instances.
- No hard-coding in main files
    - To make this code as reuseable as possible for different types of AWS web applications to host, as much as possible should be stored in the variables.tf files instead of in main. This also allows for any troubleshooting that should only have to look at one file based on the kind of issue - main/resources for issues happening across many instances, variables for issues only happening on one type of instance.

## Contributing

Since this is a personal project, this repo is not open to contributors. 
However, if you find an issue or want to suggest something to me, please feel free to submit an [issue/feature request](https://github.com/Clairefox/Terraform-Projects/issues)!

## License

See [License File](https://github.com/Clairefox/Terraform-Projects/blob/main/LICENSE) for more information.

## Contact

- Carla Young - claire.2007@live.com
- Project Link: [https://github.com/Clairefox/Terraform-Projects](https://github.com/Clairefox/Terraform-Projects)

## Acknowledgements

### Project Specific Acknowledgements

- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [Terraform Tutorials](https://learn.hashicorp.com/tutorials/terraform/aws-variables?in=terraform/aws-get-started)
- [Docker Tutorials](https://docs.docker.com/docker-hub/)
- [AWS Tutorials](https://aws.amazon.com/getting-started/)
- [AWS Terraform Example Repo](https://github.com/aws-samples/apn-blog/tree/tf_blog_v1.0/terraform_demo)
 
 ### General Acknowledgements
 
- [Best-README-Template](https://github.com/othneildrew/Best-README-Template)
- [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
- [Img Shields](https://shields.io)
- [Choose an Open Source License](https://choosealicense.com)