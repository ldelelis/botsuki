#!/usr/bin/env ruby

require 'discordrb'
require 'fullwidth'
require 'lastfm'
require 'marky_markov'
require 'net/http'
require 'tempfile'
require 'yaml'

require_relative 'lib/girls'
require_relative 'lib/memes'
require_relative 'lib/natsuki'
require_relative 'lib/admin'
require_relative 'lib/yuri'
require_relative 'lib/fluff'

$config = YAML.load_file(File.join(__dir__, 'config.yaml'))
$flavours = File.join(__dir__, 'flavours.txt')
$poems = YAML.load_file(File.join(__dir__, 'poems.yaml'))
$last_fm_instance = Lastfm.new($config['lastfmApiKey'], $config['lastfmSharedSecret'])

$bsuki = Discordrb::Commands::CommandBot.new(
  token: $config['token'],
  prefix: $config['prefix'],
  advanced_functionality: true,
  spaces_allowed: true,
  ignore_bots: true
)

$bsuki.include! Girls
$bsuki.include! Memes
$bsuki.include! Natsuki
$bsuki.include! Yuri
$bsuki.include! Admin
$bsuki.include! Fluff

$poems.keys.each do |poem|
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
          icon_url: embed_raw['icon_url']
        )
      end
    end
  end
end

$bsuki.command :postem do |event, *args|
  args[0] = '5x5'
  $bsuki.execute_command('lastfm'.to_sym, event, args)
end

$bsuki.run
