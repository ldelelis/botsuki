# :nodoc:
module Natsuki
  extend Discordrb::Commands::CommandContainer

  command(:cupcake) do |event|
    words_to_use = Random.new
    markov = MarkyMarkov::TemporaryDictionary.new(5)
    markov.parse_file $flavours
    event.channel.send_message("Here's a \
#{markov.generate_n_words words_to_use.rand(1...6)} cupcake, \
<@#{event.author.id}>!")
    markov.clear!
    return
  end
end
