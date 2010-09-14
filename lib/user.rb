class User
  attr_accessor :badges
  def initialize
    @badges = {}
    [:commits, :forks, :tags, :watchers, :place_on_watchers_rating, :users_that_forked].each do |stat|
        @badges[stat] = []
    end
  end
end

