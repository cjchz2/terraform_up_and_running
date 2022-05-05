provider "aws" {
    region = "us-east-2"
}

# Do not want the port specified in more than 1 spot. Create a variable.
# If you didnt' specify the defualt you have several ways to specify during the plan stage
#Either wait to be asked for it after running plan
# Or run the -var command-line option, with this "server_port=8080".
#Or you could set up an env var TF_VAR_server_port. You have to put TF_VAR in front
# of your name.

#You then reference the var with var.server_port.
  

variable "server_port" {
    description = "The port the server will use for HTTP requests"
    type = number
    default = 8080
}

#Output variables take existing attributes and turn them into output for you when you run
#Terraform apply and Terraform output.

output "public_ip" {
    value = aws_instance.example.public_ip
    description = "the public ip of the web server"
}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"
    ingress {
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }
}

# Dirt simple web server.
resource "aws_instance" "example" {
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]
    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF
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

Same thing but with instance tag

resource "aws_instance" "example" {
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"

    tags = {
        Name = "terraform-example"
    }
}




*/

