require 'commits_state'

class User
  attr_accessor :badges, :watchers_place, :commits, :commits_state
  def initialize
    @watchers_place = 1000
    @commits = 0
    @commits_state = CommitsState.new(self)
    @badges = {}
    [:commits, :forks, :watchers, :users_that_forked].each do |stat|
        @badges[stat] = []
    end
  end
end

