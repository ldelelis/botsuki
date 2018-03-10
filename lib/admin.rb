# Server management/administration commands that require moderation privileges
module Admin
  extend Discordrb::Commands::CommandContainer

  command(:purge,
          help_available: false,
          max_args: 1,
          required_role: ['370374223526625292'],
          usage: '[Messages to purge (defaults to 25)]') \
  do |event, *args|
    event.channel.send_message('Invalid amount') && break if args[0].to_i > 100
    to_delete = event.channel.history(args.empty? ? 25 : args[0].to_i + 1)
    event.channel.delete_messages(to_delete)
  end

  command(:timeout,
          help_available: false,
          min_args: 1,
          max_args: 2,
          required_role: ['370374223526625292'],
          usage: '<user to timeout> [seconds of timeout (defaults to 5 min)]') \
  do |event, *args|
    time_out = fork do
      user = event.message.mentions[0].on('369241481095020544')
      user.add_role($config['timeoutRole'])
      time_to_sleep = args.length > 1 ? args[1].to_i : 300
      sleep time_to_sleep
      user.remove_role($config['timeoutRole'])
    end
    Process.detach(time_out)
    return
  end
end
