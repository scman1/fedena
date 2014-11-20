require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ExamGroupsControllerTest < ActionController::TestCase

  include FactoryGirl::Syntax::Methods

  fixtures :users

  context 'with admin logged in' do
    setup do
      @controller = ExamGroupsController.new
      @request = ActionController::TestRequest.new
      @response = ActionController::TestResponse.new
      @request.session[:user_id] = 1

      @c = create(:course)
      @b = create(:batch,  :course_id => @c.id)
      @exam_group = create(:exam_group,:exam_date => Date.today)
    end

    should 'render index' do 
      get :index, {:batch_id => @b.id}
      assert_response :success
      assert_template :index
    end

    should 'render new' do 
      get :new, {:batch_id => @b.id}
      assert_response :success
      assert_template :new
    end

    should 'render new template if wrong parameters are given in new form' do 
      post :create, {:batch_id => @b.id}
      assert_template :new
    end

    should 'redirect to index if correct parameters are give in new form' do 
      post :create, {
        :exam_group => attributes_for(:exam_group),
        :batch_id => @b.id
      }
      assert_redirected_to :action => 'index'
    end

    should 'render edit' do
      get :edit, { :id => @exam_group.id, :batch_id =>@b.id}
      assert_response :success
      assert_template :edit
    end

    should 'render edit template if wrong parameters are given in edit form' do
      put :update, { :id=>@exam_group.id, :batch_id =>@b.id}
      assert_redirected_to :action => 'show'
    end

    should 'redirect to show if correct parameters are give in edit form' do # Error here
      post :update, {
        :exam_group => attributes_for(:exam_group),
        :batch_id => @b.id, :id=>@exam_group.id
      }
      assert_redirected_to :action => 'show'
    end

    should 'redirect to index if exam group is destroyed' do
      delete :destroy, {
        :batch_id => @b.id, :id=>@exam_group.id
      }
      assert_redirected_to :action => 'index'
    end

    end
  end
