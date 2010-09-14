# My achievement system has this as categories:
# - number of commits
# - number of forks made
# - number of tags in repos (I'm treating tag as a release)
# - number of watchers
# - place in global rating for watchers
# - number of users that forked users repos

# Stats are being pased by Stats::get_stats_for(user) method
# which returns a hash, where Keys are category names,
# and values are numerical ratings
# example:

# {
#  :number_of_commits => 10,
#  :place_in_global_watchers_rating => 500,
#  ...
# }

# I assume that each User has a method for getting
# achievements through Achievements object
# which represents current status for each of the categories
# and saves them into User.badges hash (which has the same keys)

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
    return if @user.badges[:commits] == "MASTER_COMMITER"
    
    if @stats[:commits] == BEGGINER
      @user.badges[:commits] = "BEGGINER"
      return
    end

    if @stats[:commits] >= JOURNEYMAN && @stats[:commits] < MASTER_COMMITER
      @user.badges[:commits] = "JOURNEYMAN"
      return
    end

    if @stats[:commits] >= MASTER_COMMITER
      @user.badges[:commits] = "MASTER COMMITER"
      return
    end

end


  




end
