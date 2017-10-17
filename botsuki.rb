require 'discordrb'
require 'simple-random'
require 'marky_markov'
require 'yaml'

$config = YAML.load_file('config.yaml')
$flavours = $config['flavoursFile']
$poems = YAML.load_file('poems.yaml')

$bsuki = Discordrb::Commands::CommandBot.new(
  token: $config['token'],
  prefix: $config['prefix'],
  advanced_functionality: true,
  spaces_allowed: true,
  ignore_bots: true)

$bsuki.command :monika \
do |event|
  event.channel.send_embed \
  do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(
      url: $config['monikammm'])
  end
end

$bsuki.command :sayori \
do |event|
  event.channel.send_message("Bring the ropes")
end

$bsuki.command :cupcake \
do |event|
  random = SimpleRandom.new
  random.set_seed(Time.now.to_time.to_i)
  wordsToUse = random.uniform(1, 5).round
  markov = MarkyMarkov::TemporaryDictionary.new(5)
  markov.parse_file $flavours
  event.channel.send_message("Here's a #{markov.generate_n_words wordsToUse} \
cupcake, <@#{event.author.id.to_s}>!")
  puts markov.clear!
end

$bsuki.command :natsuki \
do |event|
  event.channel.send_embed \
  do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(
      url: 'https://cdn.discordapp.com/attachments/369266542463942656/369548682074390529/sleep_natsuki.gif')
  end
end

$bsuki.command :yuri \
do |event|
  event.channel.send_embed \
  do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(
      url: 'https://cdn.discordapp.com/attachments/369241481095020546/369551522583019540/BeyXDzd.png')
  end
end

$poems.keys.each \
do |poem|

  $bsuki.command poem.to_sym \
  do |event|

    event.channel.send_embed \
    do |embed|

      embed_raw = $poems[poem]['embed']
      embed.description = embed_raw['description']

      if embed_raw['author']
        embed_raw = embed_raw['author']
        embed.author = Discordrb::Webhooks::EmbedAuthor.new(
          name: embed_raw['name'],
          url: embed_raw['url'],
          icon_url: embed_raw['icon_url'] )
      end
    end
  end
end

$bsuki.run
