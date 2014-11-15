require File.expand_path(File.dirname(__FILE__) + './../test_helper')

class ExamGroupTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  
  validate_presence_of :name
  have_many :exams

  context 'a new exam group' do
    setup do
      @exam_group = build(:exam_group)
    end

    should 'be valid' do
      assert @exam_group.valid?
    end

    should 'validate presence of name' do
      @exam_group.name = nil
      assert !@exam_group.valid?
    end

    should 'save current date if date is not given' do
      @exam_group.exam_date = nil
      @exam_group.save
      assert (@exam_group.exam_date == Date.today)
    end
  end
end