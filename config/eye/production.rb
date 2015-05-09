Eye.config do
  logger "/home/silvermind_bookyt/shared/log/eye.log"

  #mail :host => "mx.some.host", :port => 25, :domain => "some.host"
  #contact :errors, :mail, 'error@some.host'
  #contact :dev, :mail, 'dev@some.host'

end

Eye.application("silvermind_bookyt") do |app|

  working_dir '/home/silvermind_bookyt/current'

  group "services" do

    process :unicorn do
      pid_file "/home/silvermind_bookyt/shared/tmp/pids/unicorn.pid"
      stdall "/home/silvermind_bookyt/shared/log/eye-unicorn.log"
      start_command "bundle exec unicorn -c /home/silvermind_bookyt/current/config/unicorn.rb --daemonize"
      restart_command "kill -USR2 {PID}" # for rolling restarts

      stop_signals [:TERM, 10.seconds]

      #start_timeout 100.seconds
      #restart_grace 50.seconds
    end

    # TODO enable reminder_worker
    # RAILS_ENV=production bundle exec sidekiq -c 5 -q reminder

    # process :mailer_worker do
    #   working_dir '/home/tailorart/current'
    #   pid_file "/home/tailorart/shared/pids/mailer_worker.pid"
    #   start_command "bundle exec sidekiq -c 2 -q mailer"
    #   daemonize true
    #   stdall "log/eye-mailer_worker.log"
    # end
    #
    # process :default_worker do
    #   pid_file "/home/silvermind_bookyt/shared/tmp/pids/default_worker.pid"
    #   start_command "bundle exec sidekiq -c 2"
    #   daemonize true
    #   stdall "log/eye-default_worker.log"
    # end
    #
    # # starts the clockwork which schedule (recurring jobs / cron replacement)
    # process :clock do
    #   working_dir '/home/tailorart/current'
    #   pid_file "/home/tailorart/shared/pids/clock.pid"
    #   start_command "bundle exec clockwork config/clock.rb"
    #   daemonize true
    #   stdall "log/eye-clock.log"
    # end

  end
end
