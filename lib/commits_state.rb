class CommitsState

  attr_accessor :state, :user
  
  STATES = [ "NONE",
             "BEGINNER",
             "JOURNEYMAN",
             "MASTER COMMITER"]

  # commits
  BEGGINER = 1
  JOURNEYMAN = 20
  MASTER_COMMITER = 50
  
  def initialize(user)
    @user = user
    @state = STATES[0]
  end

  def next
    commits = @user.commits

    # STM TODO: zeby sie dalo tylko do przodu
    
    return if @user.badges[:commits].include? "MASTER_COMMITER"
    
    if @user.badges[:commits].empty? && commits == BEGGINER
      @user.badges[:commits] << "BEGGINER"
      return
    end

    if @user.badges[:commits] == ["BEGGINER"]
      if commits >= JOURNEYMAN && commits < MASTER_COMMITER
        @user.badges[:commits] << "JOURNEYMAN"
        return
      end
    end

    if @user.badges[:commits].include?("BEGGINER") && @user.badges[:commits].include?("JOURNEYMAN")
      if commits >= MASTER_COMMITER
        @user.badges[:commits] << "MASTER COMMITER"
        return
      end
    end

  end

end
