require File.dirname(__FILE__) + "/../lib/achievements"

describe Achievements do
  context "commits badges" do
    before(:each) do
      @user = User.new
    end

    it "should add a BEGGINER badge" do
      set_commits(1)
      @achievements = Achievements.new(@user)
      @achievements.for_commits
      @user.badges[:commits].include?("BEGGINER").should be_true
    end

    it "should recognize commiter as JOURNEYMAN" do
      set_commits(26)
      @achievements = Achievements.new(@user)
      @user.badges[:commits] = ["BEGGINER"]
      @achievements.for_commits
      @user.badges[:commits].include?("JOURNEYMAN").should be_true
    end

    it "should recognize commiter as MASTER COMMITER" do
      set_commits(100)
      @achievements = Achievements.new(@user)
      @user.badges[:commits] = ["BEGGINER", "JOURNEYMAN"]
      @achievements.for_commits
      @user.badges[:commits].include?("MASTER COMMITER").should be_true
    end

    it "should not recheck if user obtained MASTER COMMITER status" do
      set_commits(51)
      @user.badges[:commits] << "MASTER COMMITER"
      @achievements = Achievements.new(@user)
      @achievements.should_receive(:stats).exactly(0).times
      @achievements.for_commits
    end

  


  end
end

def set_commits(x)
  Stats.stub(:get_stats_for).and_return({:commits => x})
end

