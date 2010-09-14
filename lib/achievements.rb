# My achievement system has this as categories:
# - number of commits
# - number of forks made
# - watchers list position
# - number of users that forked users repos

# Stats are being pased by Stats::get_stats_for(user) method
# which returns a hash, where Keys are category names,
# and values are numerical ratings
# example:

# {
#  :commits => 10,
#  :global_watchers_rating => 500,
#  ...
# }

# I assume that each User has a method for getting
# achievements through Achievements object
# which represents current status for each of the categories
# and saves them into User.badges hash of arrays

require 'stats'
require 'user'

class Achievements
  attr_accessor :stats, :user

  def initialize(user)
    @user = user
    @stats = Stats.get_stats_for(user)
  end

  def for_commits
    if @user.commits != @stats[:commits]
      @user.commits = @stats[:commits]
      @user.commits_state.next
    end
  end

  def for_watchers
    if @user.badges[:watchers].empty? || (@stats[:watchers] != @user.watchers_place)
      @user.watchers_place = @stats[:watchers]
      get_badge_for_watchers
    end
  end

  # watchers
  GOLD_STAR = 10
  SILVER_STAR = 50
  BRONZE_STAR = 100
  
  def get_badge_for_watchers
    @user.badges[:watchers] = case @stats[:watchers]
                              when 1..GOLD_STAR
                                "GOLD STAR"
                              when (GOLD_STAR+1)..SILVER_STAR
                                "SILVER STAR"
                              when (SILVER_STAR+1)..BRONZE_STAR
                                "BRONZE STAR"
                              else
                                ""
                              end
  end
end
