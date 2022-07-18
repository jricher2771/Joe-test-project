
variable "ami_name" {
    type = string
    default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server"
}
variable "ami_id" {
    default = "ami-052efd3df9dad4825"
}
variable "ami_key_pair_name" {
    default = "joes-key"
}
