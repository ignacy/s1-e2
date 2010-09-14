require File.dirname(__FILE__) + "/../lib/achievements"

describe Achievements do
  context "commits badges (STATIC BADGES)" do
    before(:each) do
      @user = User.new
    end

    it "should add a BEGGINER badge" do
      set_commits(1)
      @achievements = Achievements.new(@user)
      @achievements.for_commits
      @user.badges[:commits].include?("BEGGINER").should be_true
    end
    
    it "should not add a BEGGINER badge second time" do
      set_commits(1)
      @achievements = Achievements.new(@user)
      @achievements.for_commits
      @achievements.for_commits
      @user.badges[:commits].should == ["BEGGINER"]
    end

    it "should recognize commiter as JOURNEYMAN" do
      set_commits(26)
      @achievements = Achievements.new(@user)
      @user.badges[:commits] = ["BEGGINER"]
      @achievements.for_commits
      @user.badges[:commits].include?("JOURNEYMAN").should be_true
    end

    it "should not add JOURNEYMAN second time" do
      set_commits(33)
      @achievements = Achievements.new(@user)
      @user.badges[:commits] = ["BEGGINER"]
      @achievements.for_commits
      @achievements.for_commits
      @user.badges[:commits].should == ["BEGGINER", "JOURNEYMAN"]
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


  context "watchers list (DYNAMIC BADGES)" do
    before(:each) do
      @user = User.new
    end

    it "should add a GOLD STAR if place in top 10" do
      set_watchers(3)
      @achievements = Achievements.new(@user)
      @achievements.for_watchers
      @user.badges[:watchers].should == "GOLD STAR"
    end

    it "should add a SILVER STAR if place in top 10" do
      set_watchers(21)
      @achievements = Achievements.new(@user)
      @achievements.for_watchers
      @user.badges[:watchers].should == "SILVER STAR"
    end

    it "should add a BRONZE STAR if place in top 10" do
      set_watchers(90)
      @achievements = Achievements.new(@user)
      @achievements.for_watchers
      @user.badges[:watchers].should == "BRONZE STAR"
    end

    it "should have no starts if position is > 100" do
      set_watchers(3212)
      @achievements = Achievements.new(@user)
      @achievements.for_watchers
      @user.badges[:watchers].should == ""
    end
  end
end

def set_commits(x)
  Stats.stub(:get_stats_for).and_return({:commits => x})
end

def set_watchers(x)
  Stats.stub(:get_stats_for).and_return({:watchers => x})
end

