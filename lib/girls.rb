module Girls

  extend Discordrb::Commands::CommandContainer

  command(:sayori) \
  do |event|
    event.channel.send_message("Bring the ropes")
  end

  command(:monika) \
  do |event|
    event.channel.send_embed \
    do |embed|
      embed.image = Discordrb::Webhooks::EmbedImage.new(
        url: 'https://i.imgur.com/YhJKkyO.png')
    end
  end

  command(:natsuki) \
  do |event|
    event.channel.send_embed \
    do |embed|
      embed.image = Discordrb::Webhooks::EmbedImage.new(
        url: 'https://cdn.discordapp.com/attachments/369266542463942656/369548682074390529/sleep_natsuki.gif')
    end
  end

  command(:yuri) \
  do |event|
    event.channel.send_embed \
    do |embed|
      embed.image = Discordrb::Webhooks::EmbedImage.new(
        url: 'https://cdn.discordapp.com/attachments/369241481095020546/369551522583019540/BeyXDzd.png')
    end
  end

end
