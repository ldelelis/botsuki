# Oh god i love them
module Memes
  extend Discordrb::Commands::CommandContainer

  command(:qt) do |event|
    event.channel.send_embed \
    do |embed|
      embed.image = Discordrb::Webhooks::EmbedImage.new(
        url: 'https://cdn.discordapp.com/attachments/369249313240383508/373869695041929236/image.jpg'
      )
    end
  end

  command(:fullwidth) do |_, *args|
    args.join(' ').to_fullwidth
  end
end
