require File.dirname(__FILE__) + "/../lib/stats"

describe Stats do
  context "provides random values for stats" do
    it "should return stats hash" do
      user = mock("User")
      stats = Stats.get_stats_for(user)
      stats.should be_a_kind_of(Hash)
      [:commits, :forks, :watchers, :users_that_forked].each do |stat|
        stats[stat].should_not be_nil
      end
      
    end
  end
end
