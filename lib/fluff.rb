# Multiple utilities for entertainment
module Fluff
  extend Discordrb::Commands::CommandContainer

  def _fail_no_user(event)
    event.channel.send_message('You have not set a last.fm user. Run the command specifying one')
  end

  def add_last_fm_user(event, user)
    @lastfm[event.author.id] = user
    File.write(File.join(__dir__, '../lastfm.yaml'), @lastfm.to_yaml)
    event.channel.send_message("Your last.fm user has been set to #{user}")
  end

  def generate_mosaic(event, size)
    if @lastfm[event.author.id]
      lfm_user = @lastfm[event.author.id]
      tapmusic_domain = 'tapmusic.net'
      tapmusic_url = "/collage.php?user=#{lfm_user}&type=7day&size=#{size}&caption=true"
      message = event.channel.send_message("Generating collage for <@#{event.author.id}>...")
      collage = Tempfile.new('collage')
      Net::HTTP.start(tapmusic_domain) do |http|
        resp = http.get(tapmusic_url)
        collage.write(resp.body)
      end
      collage.close!
      message.edit('http://' + tapmusic_domain + tapmusic_url)
    else
      _fail_no_user(event)
    end
  end

  module_function :add_last_fm_user, :generate_mosaic, :_fail_no_user

  command(:lastfm) do |event, *args|
    @lastfm = YAML.load_file(File.join(__dir__, '../lastfm.yaml'))
    if args.empty? && !(@lastfm.key? event.author.id)
      _fail_no_user(event)
      return
    end
    unless args.empty?
      case args[0].to_s
      when '3x3'
        generate_mosaic(event, '3x3')
      when '5x5'
        generate_mosaic(event, '5x5')
      else
        add_last_fm_user(event, args[0].to_s)
      end
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
