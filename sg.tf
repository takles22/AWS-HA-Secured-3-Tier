resource "aws_security_group" "sg_HA" {
  
  name        = "sg-AH-3-tire"
  vpc_id      = aws_vpc.vpc.id
  dynamic "ingress" {
    for_each = var.ingree_port
    content {
        from_port        = var.ingree_port[each.value]
        to_port          = var.ingree_port[each.value]
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }   
  }

    dynamic "egress" {
    for_each = var.egree_port
    content {
        from_port        = var.egree_port[each.value]
        to_port          = var.egree_port[each.value]
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }   
  }
}
