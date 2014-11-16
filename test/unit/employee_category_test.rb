require File.expand_path(File.dirname(__FILE__) + './../test_helper')

class EmployeeCategoryTest < ActiveSupport::TestCase

  include FactoryGirl::Syntax::Methods
  
  have_many :employees
  have_many :employee_positions
  #have_named_scope :active, :conditions => {:status => true }


  context 'a new department' do
    setup { @category = build(:employee_category) }

    should 'be new record' do
      assert @category.new_record?
    end

    should 'be valid' do
      assert @category.valid?
    end

    should 'validate presence of name' do
      @category.name = nil
      assert !@category.valid?
      assert @category.errors[:name].any?
    end

    should 'validate presence of prefix' do
      @category.prefix = nil
      assert !@category.valid?
      assert @category.errors[:prefix].any?
    end

    should 'not create a category with same prefix' do
      @department = create(:general_emp_category)
      @department2 = build(:general_emp_category)
      assert !@department2.valid?
      assert @department2.errors[:prefix].any?
    end

    should 'not create a category with same name' do
      @department = create(:general_emp_category)
      @department2 = build(:general_emp_category)
      assert !@department2.valid?
      assert @department2.errors[:name].any?
    end



  end
end
