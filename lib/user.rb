class User
  attr_accessor :badges
  def initialize
    @badges = {}
    [:commits, :forks, :watchers, :users_that_forked].each do |stat|
        @badges[stat] = []
    end
  end
end

