require_relative 'lib/api'
require_relative 'lib/api_with_memoization'
require 'benchmark'


API_KEY = 'MUG1NE4ORILJOLZN'
show = 'FRIENDS'
show_blurb = false
show_ep_number = true
show_season_number = true
show_first_aired = false

Highlander::EpisodeRandomizer.configure do |config|
  config.api_key = API_KEY
  config.show = show
  config.show_blurb = show_blurb
  config.show_first_aired = show_first_aired
  config.show_ep_number = show_ep_number
  config.show_season_number = show_season_number
end

#puts Highlander::EpisodeRandomizer.randomize

### With Memoization
Highlander::EpisodeRandomizerMemoized.configure do |config|
  config.api_key = API_KEY
  config.show = show
  config.show_blurb = show_blurb
  config.show_first_aired = show_first_aired
  config.show_ep_number = show_ep_number
  config.show_season_number = show_season_number
end

### Benchmarking
n = 3
Benchmark.bm do |benchmark|
  benchmark.report('with memoization') do
    n.times do
      Highlander::EpisodeRandomizerMemoized.randomize
    end
  end

  benchmark.report('without memoization') do
    n.times do
      Highlander::EpisodeRandomizer.randomize
    end
  end
end
