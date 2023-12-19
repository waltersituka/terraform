variable "db_storage" {
    description = "provide value for db storage"
    type = number
    default = 10
  
}

variable "storage_type" {
    description = "provide storagetype value"
    type = string
    default = "gp2"
  
}
variable "db_name" {
    description = "db name"
    type = string
    default = "devdb"
  
}

variable "engine" {
    description = "db engine"
    type = string
    default = "postgres"
  
}

variable "engine_version" {
    description = "db_engine_version"
    type = string
    default = "12"
  
}

variable "skip_final_snapshot" {
    description = "enable or disable final_snapshot"
    type = bool
    default = true
  
}

variable "instance_class" {
    description = "db_instance_type"
    type = string
    default = "db.t3.micro"
  
}

variable "username" {
    description = "db_username"
    type = string
    default = "postgres"
  
}

variable "password" {
    description = "username password"
    type = string
    default = "deprotech"
  
}
variable "parameter_group_name" {
    description = "group_name"
    type = string
    default = "default.postgres12"
  
}

variable "ami" {
    description = "amazone machine image"
    type = string
    default = "ami-0759f51a90924c166"
  
}

variable "instance_type" {
    description = "specific type of instance"
    type = string
    default = "t2.micro"
  
}

variable "availability_zone" {
    description = "choice of availability zone"
    type = string
    default = "us-east-1a"
  
}

variable "key_name" {
    description = "main key name"
    type = string
    default = "ec2"
  
}

