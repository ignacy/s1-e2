class User
  attr_accessor :badges, :watchers_place
  def initialize
    @watchers_place = rand(200)
    @badges = {}
    [:commits, :forks, :watchers, :users_that_forked].each do |stat|
        @badges[stat] = []
    end
  end
end

