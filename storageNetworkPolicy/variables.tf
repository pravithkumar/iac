variable "resource_group_name" {
  type = string
}

variable "storageAccountName" {
  type = string
}

variable "defalutaction" {
  type = string
}

//variable "subnetid" {
  //type = list(string)
//}

variable "SubnetIDlist" {
  type = list(any)
}