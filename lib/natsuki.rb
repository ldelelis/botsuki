module Natsuki

  extend Discordrb::Commands::CommandContainer

  command(:cupcake) \
  do |event|
    wordsToUse = Random.new
    markov = MarkyMarkov::TemporaryDictionary.new(5)
    markov.parse_file $flavours
    event.channel.send_message("Here's a \
#{markov.generate_n_words wordsToUse.rand(1...6)} cupcake, \
<@#{event.author.id.to_s}>!")
    markov.clear!
    return
  end

end
