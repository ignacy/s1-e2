module Stats
  # User can be anything - it's not used
  # I'm just passing it so the API makes sense
  def Stats.get_stats_for(user)
    number_of = {
      :commits => rand(1000),
      :forks => rand(100),
      :tags => rand(100),
      :watchers => rand(10000),
      :place_on_watchers_rating => rand(1000),
      :users_that_forked => rand(200)
    }
  end
end

