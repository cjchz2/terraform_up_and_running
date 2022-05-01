provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "example" {
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"

    tags = {
        Name = "terraform-example"
    }
}



/*
General syntax for creating a resource in Terraform...

resource "<PROVIDER>_<TYPE>" "<NAME>" {
    [CONFIG ...]
}

Where PROVIDER is the cloud provider.
Where TYPE is a type of resource to create in that provider (like EC2 instance).
Where NAME is the identifier you can use to refer to the resource.
Where CONFIG is one or more args that are specific to that resource.


For example, to deploy an EC2 instance in AWS you use the "aws_instance" resource.
So the provider is AWS and the TYPE is instance.

resource "aws_instance" "example" {
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
}

Remember AMIs are region specific.



*/

