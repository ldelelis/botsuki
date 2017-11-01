module Yuri

  extend Discordrb::Commands::CommandBot

  command(:trap) \
  do |event|
    event.channel.send_embed \
    do |embed|
      embed.image = Discorddb::Webhooks::EmbedImage.new(
        url: 'https://i.redd.it/dtpzrynmprtz.jpg')
    end
  end

  command(:bodies) \
  do |event|
    event.channel.send_embed \
    do |embed|
      embed.image = Discorddb::Webhooks::EmbedImage.new(
        url: 'https://i.redd.it/b9s9jndwv7tz.jpg')
    end
  end

  command(:scent) \
  do |event|
    event.channel.send_embed \
    do |embed|
      embed.image = Discorddb::Webhooks::EmbedImage.new(
        url: 'https://i.redd.it/fzqtoxg3mptz.jpg')
    end
  end

end
