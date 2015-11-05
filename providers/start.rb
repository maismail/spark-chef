action :start_master do

  bash "start-master" do
    user node[:spark][:user]
    group node[:spark][:group]
    code <<-EOF
     #{node[:spark][:home]}/sbin/start-master.sh
    EOF
  end
 
end


action :start_worker do

  bash "start-worker" do
    user node[:spark][:user]
    group node[:spark][:group]
    code <<-EOF
    cd #{node[:spark][:home]}    
# Spark 1.4.x
#    ./sbin/start-slave.sh #{new_resource.master_url}
# Spark 1.3.x
    ./sbin/start-slave.sh #{new_resource.worker_id} #{new_resource.master_url} || true
    EOF
#    not_if "cd #{node[:spark][:home]} && ./sbin/start-slave.sh --properties-file #{node[:spark][:home]}/conf/spark-defaults.conf | grep \"stop it first\""
  end
 
end
