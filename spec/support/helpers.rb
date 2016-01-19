module Helpers
  def random_word
    [FFaker::Lorem.word, Time.now.to_i, rand(1..9)].join('_')
  end
end
