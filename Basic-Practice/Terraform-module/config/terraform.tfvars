region = "ap-south-1"
access_key = ""
secret_key = ""

vpc_config = {

    vpc01 = {
        vpc_cidr_block = "192.168.0.0/16"
        tags = {
            "Name" = "my_vpc"
        }
    }
}

subnet_config = {
    "public-ap-south-1a" = {
      vpc_name = "vpc01"  
      cidr_block = "192.168.0.0/18"  
      availability_zone = "ap-south-1a"
      tags = {
        "Name" = "public-ap-south-1a"
      }
    }

    "public-ap-south-1b" = {
      vpc_name = "vpc01"    
      cidr_block = "192.168.64.0/18"  
      availability_zone = "ap-south-1b"
      tags = {
        "Name" = "public-ap-south-1b"
      }
    }

    "private-ap-south-1a" = {
      vpc_name = "vpc01"    
      cidr_block = "192.168.128.0/18"  
      availability_zone = "ap-south-1a"
      tags = {
        "Name" = "private-ap-south-1a"
      }
    }

    "private-ap-south-1b" = {
      vpc_name = "vpc01"    
      cidr_block = "192.168.192.0/18"  
      availability_zone = "ap-south-1b"
      tags = {
        "Name" = "public-ap-south-1b"
      }
    }
}

igw_config = {
   igw01 = {
     vpc_name = "vpc_01"
    
     tags = {
      "Name" =  "My_igw"
    }
  }
}

elastic_IP_config = {

eip01 = {

  tags = {
    "Name" = "nat01"
  }
}

eip02 = {

  tags = {
    "Name" = "nat02"
  }
}

}

nat_GW_config = {

  natgW01 = {

    eip_name = "eip01"

    subnet_name = "public-ap-south-1a"

    tags = {

      "Name" = "natGW01"
    }

  }

  natgW02 = {

    eip_name = "eip02"

    subnet_name = "public-ap-south-1b"

    tags = {

      "Name" = "natGW02"
    }

  }

}

route_table_config = {

  RT01 = {
    private = 0   
    vpc_name = "vpc01"
     gateway_name= "igw01"

     tags = {

         "Name" = "Public-Route"
     }
}

  RT02 = {
    private = 1 
    vpc_name = "vpc01"
     gateway_name= "natGW01"

     tags = {

          "Name" = "Private-Route"
     }

}

  RT03 = {
    private = 1 
    vpc_name = "vpc01"
    gateway_name= "natGW02"
    tags = {

     "Name" = "Private-Route"
    }
}

}

aws_rt_association_config = {

  RT01Assoc = {
    subnet_name = "public-ap-south-1a"

    route_table_name = "RT01"

  }

  RT02Assoc = {

   subnet_name = "public-ap-south-1a"

   route_table_name = "RT02"
  }

  RT03Assoc = {

    subnet_name = "public-ap-south-1a"

    route_table_name = "RT03"

  }

  RT04Assoc = {

    subnet_name = "public-ap-south-1a"

    route_table_name = "RT03"
  }

}