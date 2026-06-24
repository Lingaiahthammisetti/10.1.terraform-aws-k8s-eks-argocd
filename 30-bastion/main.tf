module "bastion" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    name ="${var.project_name}-${var.environment}-bastion"
    instance_type = "t3.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]

    #Convert StringList to list and get first element
    #subnet_id = element(split(",",data.aws_ssm_parameter.public_subnet_ids.value),0)
    subnet_id = local.public_subnet_id
    user_data = file("bastion.sh")
    ami   = data.aws_ami.ami_info.id
    tags =merge(
        var.common_tags,
        {
            name ="${var.project_name}-${var.environment}-bastion"
        }
    )
}
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.11.1"
  zone_id = var.zone_id
  records = [
    {
        name    = "bastion"
        type    = "A"
        ttl     = 1
        records = [
            module.bastion.public_ip
        ]
    }
  ]
}