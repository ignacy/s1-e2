class CommitsState

  attr_accessor :state, :user
  
  # commits
  BEGINNER = 1
  JOURNEYMAN = 20
  MASTER_COMMITER = 50
  
  def initialize(user)
    @user = user
  end

  def next
    return if @user.badges[:commits].include? "MASTER_COMMITER"
    
    if beginner?
      @user.badges[:commits] << "BEGINNER"
      return
    end

    if has_beginner_badge?
      if journeyman?
        @user.badges[:commits] << "JOURNEYMAN"
        return
      end
    end

    if has_beginner_and_journeyman_badges?
      if master_commiter?
        @user.badges[:commits] << "MASTER COMMITER"
        return
      end
    end
  end

  private
  
  def beginner?
    @user.badges[:commits].empty? && @user.commits == BEGINNER
  end

  def journeyman?
    @user.commits >= JOURNEYMAN && @user.commits < MASTER_COMMITER
  end

  def master_commiter?
    @user.commits >= MASTER_COMMITER
  end

  def has_beginner_and_journeyman_badges?
    @user.badges[:commits].include?("BEGINNER") && @user.badges[:commits].include?("JOURNEYMAN")
  end

  def has_beginner_badge?
    @user.badges[:commits] == ["BEGINNER"]
  end




end
