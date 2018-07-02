module Fluent
  require_relative 'omslog'
  require_relative 'oms_common'
  require 'json'
  require 'open3'


  class BatchFilter < Filter
    Fluent::Plugin.register_filter('filter_batch', self)

    BASE_DIR = File.dirname(File.expand_path('..', __FILE__))
    RUBY_DIR = BASE_DIR + '/ruby/bin/ruby '
    SCRIPT = BASE_DIR + '/bin/batchmanifestreader.rb '

        attr_accessor :command

    def configure(conf)
      super
      @hostname = OMS::Common.get_hostname or "unknown"
      @command = "sudo " << RUBY_DIR << SCRIPT
      @clustername = ""
      @clusternode = ""
    end

    def start
      super
      Open3.popen3(@command) {|stdin, stdout, stderr, wait_thr|
          pid = wait_thr.pid
          stdin.close
          parsed = JSON.parse(stdout.read)
          @clustername = parsed["cluster_name"]
          @clusternode = parsed["cluster_node"]
          wait_thr.value
      }
    end

    def shutdown
      super
    end

    def filter(tag, time, record)
      record["ClusterName"] = @clustername
      record["HostName"] = @hostname
      record["ClusterNode"] = @clusternode
      record
    end
  end
end
