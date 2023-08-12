// this contains all variables



variable "region-name" {
  type        = string
  default     = "eu-west-2"
  description = "changing region name into variable."
}






variable "vpc-cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "changing vpc cidr into variable."
}


variable "tenancy" {
  type        = string
  default     = "default"
  description = "changing instance_tenancy into variable."
}


 
 
variable "Pro-pub-cidr-1" {
  default     = "10.0.1.0/24"
}




variable "Pro-pub-cidr-2" {
  default     = "10.0.2.0/24"
}


variable "az1" {
  default     = "eu-west-2a"
}



variable "az2" {
  default     = "eu-west-2a"
}



variable "Pro-priv-cidr-1" {
  default     = "10.0.3.0/24"
}



variable "Pro-priv-cidr-2" {
  default     = "10.0.4.0/24"
}



variable "azz1" {
  default     = "eu-west-2b"
}



variable "azz2" {
  default     = "eu-west-2b"
}
