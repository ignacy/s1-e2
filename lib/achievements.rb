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

require 'stats'

class Achievements



end
