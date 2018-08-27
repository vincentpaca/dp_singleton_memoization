require 'bundler'
Bundler.require

require_relative 'configuration'

module Highlander
  class EpisodeRandomizerMemoized

    class << self

      def configure
        yield(configuration) if block_given?
      end

      def configuration
        Configuration.instance
      end

      def randomize
        formatted_episode
      end

      private

      def formatted_episode
        { show: configuration.show, title: random_episode.name }.tap do |h|
          h[:first_aired] = random_episode.firstAired if configuration.show_first_aired
          h[:ep_number] = random_episode.airedEpisodeNumber if configuration.show_ep_number
          h[:season_number] = random_episode.airedSeason if configuration.show_season_number
          h[:show_blurb] = random_episode.overview if configuration.show_blurb
        end
      end

      def random_episode
        @_random_episode ||= best_result.episodes.sample
      end

      def best_result
        client.best_search(configuration.show)
      end

      def client
        TVDB.new(apikey: configuration.api_key, language: 'en')
      end

    end
  end
end
