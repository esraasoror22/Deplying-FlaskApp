locals { 
  inbound_ports = ["80", "443", "8080", "22"]    
} 

#locals.inbound_ports


locals {

  lb_inbound_rules = ["80" ,"443", "4000"]
}

#local.lb_inbound_rules