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

  BEGGINER = 1
  JOURNEYMAN = 20
  MASTER_COMMITER = 50
  
  def initialize(user)
    @user = user
    @stats = Stats.get_stats_for(user)
  end

  def for_commits
    return if @user.badges[:commits].include? "MASTER_COMMITER"
    
    if @user.badges[:commits].empty? && @stats[:commits] == BEGGINER
      @user.badges[:commits] << "BEGGINER"
      return
    end

    if @user.badges[:commits] == ["BEGGINER"]
      if @stats[:commits] >= JOURNEYMAN && @stats[:commits] < MASTER_COMMITER
        @user.badges[:commits] << "JOURNEYMAN"
        return
      end
    end

    if @user.badges[:commits].include?("BEGGINER") && @user.badges[:commits].include?("JOURNEYMAN")
      if @stats[:commits] >= MASTER_COMMITER
        @user.badges[:commits] << "MASTER COMMITER"
        return
      end
    end
end


  




end
