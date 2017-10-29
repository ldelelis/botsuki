module Admin

  extend Discordrb::Commands::CommandContainer

  command(:purge,
          help_available: false,
          max_args: 1,
          required_role: ['370374223526625292'],
          usage: "[Messages to purge (defaults to 25)]") \
  do |event, *args|
    event.channel.send_message("Invalid amount") && break if args[0].to_i > 100
    toDelete = event.channel.history(args.empty? ? 25 : args[0].to_i + 1)
    event.channel.delete_messages(toDelete)
  end

  command(:timeout,
          help_available: false,
          min_args: 1,
          max_args: 2,
          required_role: ['370374223526625292'],
          usage: "<user to timeout> [seconds of timeout (defaults to 5 min)]") \
  do |event, *args|
    timeOut = fork do
      user = event.message.mentions[0].on('369241481095020544')
      user.add_role($config['timeoutRole'])
      sleep (if args.length == 2 then args[2].to_i else 300 end)
      user.remove_role($config['timeoutRole'])
    end
    Process.detach(timeOut)
    return
  end
end
