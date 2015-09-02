#
# Cookbook Name:: NIC_bonding
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bond_databag = data_bag_item('bond_info', 'baremetal_list')

bond_databag['nodes'].each_key do |nodename|

host = nodename

template "/var/www/config/#{host}_bond_script.sh" do 
	source "bond_script.sh.erb"
	mode '0755'
	variables ({
		:hostname => bond_databag['nodes'][host]['hostname'],
		:ip => bond_databag['nodes'][host]['ip'],
		:netmask => bond_databag['nodes'][host]['netmask'],
		:gateway => bond_databag['nodes'][host]['gateway'],
		:bondname => bond_databag['nodes'][host]['bond_info']['bondname'],
		:bond_interface1 => bond_databag['nodes'][host]['bond_info']['bond_interface1'],
		:bond_interface2 => bond_databag['nodes'][host]['bond_info']['bond_interface2']
	})
	action :create
	end
end
