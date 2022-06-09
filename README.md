# Carla's Terraform Web App

## Table of Contents
1. <a href="#Project-Requirements">Project Requirements</a>
    1. <a href="#Extra-Credit">Extra Credit</a>
2. <a href="#Built-With">Built With</a>
3. <a href="#Using-This-Project">Using This Project</a>
    1. <a href="#Prerequisites">Prerequisites</a>
    2. <a href="#Setup">Setup</a>
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
* [Markdown](https://www.markdownguide.org/basic-syntax/#reference-style-links)

## Using This Project

### Prerequisites

### Setup

### Module Inputs

### Design Notes

## Contributing
Since this is a personal project, this repo is not open to contributors. 
However, if you find an issue or want to suggest something to me, please feel free to submit an [issue/feature request](https://github.com/Clairefox/Terraform-Web-App/issues)!

## License

## Contact
* Carla Young - claire.2007@live.com
* Project Link: [https://github.com/Clairefox/Terraform-Web-App](https://github.com/Clairefox/Terraform-Web-App)

## Acknowledgements
* [Best-README-Template](https://github.com/othneildrew/Best-README-Template)
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Img Shields](https://shields.io)
* [Choose an Open Source License](https://choosealicense.com)