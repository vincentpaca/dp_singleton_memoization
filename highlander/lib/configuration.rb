require 'singleton'

module Highlander
  class Configuration
    include Singleton

    attr_accessor :api_key,
      :show,
      :show_first_aired,
      :show_blurb,
      :show_ep_number,
      :show_season_number
  end
end
