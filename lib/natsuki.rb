module Natsuki

  extend Discordrb::Commands::CommandContainer

  command(:cupcake) \
  do |event|
    random = SimpleRandom.new
    random.set_seed(Time.now.to_time.to_i)
    wordsToUse = random.uniform(1, 5).round
    markov = MarkyMarkov::TemporaryDictionary.new(5)
    markov.parse_file $flavours
    event.channel.send_message("Here's a #{markov.generate_n_words wordsToUse} \
cupcake, <@#{event.author.id.to_s}>!")
    markov.clear!
    return
  end

end
