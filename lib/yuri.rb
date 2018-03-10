# :nodoc:
module Yuri
  extend Discordrb::Commands::CommandContainer

  command(:trap) do |event|
    event.channel.send_embed \
    do |embed|
      embed.image = Discordrb::Webhooks::EmbedImage.new(
        url: 'https://i.redd.it/dtpzrynmprtz.jpg'
      )
    end
  end

  command(:bodies) do |event|
    event.channel.send_embed \
    do |embed|
      embed.image = Discordrb::Webhooks::EmbedImage.new(
        url: 'https://i.redd.it/b9s9jndwv7tz.jpg'
      )
    end
  end

  command(:scent) do |event|
    event.channel.send_embed \
    do |embed|
      embed.image = Discordrb::Webhooks::EmbedImage.new(
        url: 'https://i.redd.it/fzqtoxg3mptz.jpg'
      )
    end
  end
end
