# Multiple utilities for entertainment
module Fluff
  extend Discordrb::Commands::CommandContainer

  def add_last_fm_user(key, user)
    @lastfm[key] = user
    File.write(File.join(__dir__, '../lastfm.yaml'), @lastfm.to_yaml)
  end

  module_function :add_last_fm_user

  command(:lastfm) do |event, *args|
    @lastfm = YAML.load_file(File.join(__dir__, '../lastfm.yaml'))
    if args.empty? && !(@lastfm.key? event.author.id)
      event.channel.send_message('You have not set a last.fm user. Run the command specifying one')
      return
    end
    unless args.empty?
      add_last_fm_user(event.author.id, args[0].to_s)
      event.channel.send_message("Your last.fm user has been set to #{args[0]}")
      return
    end
    last_fm_user = @lastfm[event.author.id]
    last_fm_user_data = $last_fm_instance.user.get_info(user: last_fm_user)
    played_tracks = []
    current_playing = ''
    $last_fm_instance.user.get_recent_tracks(user: last_fm_user, limit: 5).each do |hash|
      current_playing = "#{hash['artist']['content']} - #{hash['name']}" if hash.key? 'nowplaying'
      played_tracks.push "#{hash['artist']['content']} - #{hash['name']}" unless hash.key? 'nowplaying'
    end
    event.channel.send_embed do |embed|
      embed.title = last_fm_user_data['name']
      embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(
        url: last_fm_user_data['image'][0]['content']
      )
      embed.add_field(
        name: 'Recent tracks:',
        value: played_tracks.join("\n")
      )
      unless current_playing.empty?
        embed.add_field(
          name: 'Now Playing:',
          value: current_playing
        )
      end
    end
  end

  command(:booru) { |event, *args| }
end
