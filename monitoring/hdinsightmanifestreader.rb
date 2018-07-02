# cluster_name=`sudo python -c "from hdinsight_common.AmbariHelper import AmbariHelper; print AmbariHelper().get_cluster_manifest().deployment.cluster_name"`
cluster_name=ENV['AZ_BATCH_POOL_ID']
cluster_node=ENV['AZ_BATCH_NODE_ID']

# old clusters manifest does not have this field
# has_cluster_type=`sudo python -c "from hdinsight_common.AmbariHelper import AmbariHelper; print AmbariHelper().get_cluster_manifest().settings.has_key('cluster_type')"`
# cluster_type = "unknown"
# if has_cluster_type.strip == "True"
#    cluster_type = `sudo python -c "from hdinsight_common.AmbariHelper import AmbariHelper; print AmbariHelper().get_cluster_manifest().settings['cluster_type']"`
# end
results = '{"cluster_name":"'+ cluster_name.strip + '", "cluster_node":"'+ cluster_node.strip + '"}'
puts results
