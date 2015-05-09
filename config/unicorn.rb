# Setup paths
puts "STARTING A UNICORN for Bookyt"

# Location

app_path = File.expand_path("../../", __FILE__)
current_path = File.join(app_path, 'current')
shared_path = File.join(app_path, 'shared')
pid_file = File.join(shared_path, 'tmp/pids', 'unicorn.pid')

# Configuration
worker_processes 5
timeout 60 # restarts workers that hang for 30 seconds

# This loads the application in the master process before forking
# worker processes
# Read more about it here:
# http://unicorn.bogomips.org/Unicorn/Configurator.html
preload_app true


HttpRequest::DEFAULTS["rack.url_scheme"] = "http"
HttpRequest::DEFAULTS["HTTPS"] = "off"
HttpRequest::DEFAULTS["HTTP_X_FORWARDED_PROTO"] = "http"


preload_app true # faster worker spawn time and needed for newrelic. http://newrelic.com/docs/troubleshooting/im-using-unicorn-and-i-dont-see-any-data
pid pid_file
listen File.join(shared_path, 'tmp/sockets', 'unicorn.sock'), :backlog => 1024 # default = 1024
working_directory current_path

stderr_path File.join(shared_path, 'log', 'unicorn.stderr.log')
stdout_path File.join(shared_path, 'log', 'unicorn.stdout.log')

# Zero downtime deployment
# Kill old process as the new finished spinning up
before_fork do |server, worker|

  puts "before_fork UNICORN for Bookyt"

  # This option works in together with preload_app true setting
  # What is does is prevent the master process from holding
  # the database connection
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  ##
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.

  old_pid = "#{pid_file}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  # Here we are establishing the connection after forking worker
  # processes
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
