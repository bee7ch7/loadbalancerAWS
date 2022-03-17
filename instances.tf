resource "aws_instance" "win-instance-1" {
    ami = "ami-0156572b534935781" // windows server 2022
    instance_type = "t2.micro"

    subnet_id = aws_subnet.subnet1.id
    vpc_security_group_ids = [aws_security_group.sec-group.id]

    key_name = "meldm" // the name of the key pair in aws 

    user_data = file("powershell/server1.ps1")

    tags = {
        "Name" = "Win-instance-1"
    }

}

resource "aws_instance" "win-instance-2" {
    ami = "ami-0156572b534935781" // windows server 2022
    instance_type = "t2.micro"

    subnet_id = aws_subnet.subnet2.id
    vpc_security_group_ids = [aws_security_group.sec-group.id]

    key_name = "meldm" // the name of the key pair in aws 

    user_data = file("powershell/server2.ps1")

    tags = {
        "Name" = "Win-instance-2"
    }

}