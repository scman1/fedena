require File.expand_path(File.dirname(__FILE__) + './../test_helper')

class EmployeeDepartmentTest < ActiveSupport::TestCase
  
  include FactoryGirl::Syntax::Methods
  
  have_many :employees
  #have_named_scope :active, :conditions => {:status => true }
   
  context 'a new department' do
    setup { @department = build(:employee_department) }

    should 'be new record' do
      assert @department.new_record?
    end

    should 'be valid' do
      assert @department.valid?
    end

    should 'validate presence of name' do
      @department.name = nil
      assert_invalid @department
      assert @department.errors[:name].any?
    end

    should 'not create a department with same code' do
      @department = create(:general_department)
      @department2 = build(:general_department)
      assert_invalid @department2
      assert @department2.errors[:code].any?
    end

    should 'not create a department with same name' do
      @department = create(:general_department)
      @department2 = build(:general_department)
      assert_invalid @department2
      assert @department2.errors[:name].any
    end
  end
end
