# An AWS solution with ansible to deploy a dev micro service env

It creates an EC2 instance, run the playbook `provision.yml` which installs nodejs and a helloworld node service with pm2 registered as a service.

Role `ec2_save_ami_and_terminate_instance` can save the image launched previously in the playbook as an AMI

And role `ec2_rolling_asg_update` can create a launch config with the new AMI, update an existing auto scaling group, and deploy instances in a rolling fashion so no down time.

These two roles are not in the playbook because they depends on an existing auto scaling group.

## Dependencies

- Ansible, version >= 2.0
- Python with boto

## Local Test with Docker and Test Kitchen

To install test dependencies:

    gem install bundler
    bundle

Run test:

    kitchen test

Destroy:

    kitchen destroy

## AWS Requirements

First you need to configure AWS Access Key and Secret.

Define `ami_template_name` in group_vars, with an existing ubuntu16 prebuilt image, and ansible user's public key should be within the base image, in order to ssh to it.

Update `region`, `subnet_id`, and `group_id` according to your situation.

(The security group should allow you to access internet in order to install dependencies and pull from git.)

## Provision an AWS instance and Deploy Service

    ansible-galaxy install -r requirements.yml
	ansible-playbook -i inventories/dev/ playbooks/provision.yml

