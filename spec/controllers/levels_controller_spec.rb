require 'spec_helper'

describe LevelsController do
  def valid_session
    {}
  end

  def valid_attributes
    {  }
  end

  before do
    @user = create(:user)
    sign_in :user, @user
    @topic = create(:topic)
    @topic1 = create(:topic)
  end

  it 'Should display the index' do
    level = create(:level)
    get :index
    render_template('home#index')
    should respond_with(:success)
    level.should_not be_nil
  end

  it 'Should show number of cookies for the level' do
    level_cookies = @topic.cookies + @topic1.cookies
    level_cookies.should_not be_nil
  end

  context 'Only admin can create level' do
    before do
      @user = create(:admin)
      sign_in :user, @user
    end

    describe "GET new" do
      it "assigns a new level as @level" do
        get :new, {}, valid_session
        assigns(:level).should be_nil
      end
    end

    describe "POST create" do
      it 'The save is successful', :fail => true do
        post :create, :level => @level.attributes      
        assert_redirected_to levels_path
        flash[:notice].should ==  I18n.t('level.created')
      end
    end
  end

  context "When clicking on the level" do
    it 'Should show list of topics' do
      @topic.title.should_not be_nil
      @topic1.title.should_not be_nil
    end
  end

  context "When the level ends" do
    it 'Should un-lock the bonus round'
  end
end
