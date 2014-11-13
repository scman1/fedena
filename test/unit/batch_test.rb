require File.expand_path(File.dirname(__FILE__) + './../test_helper')

class BatchTest < ActiveSupport::TestCase
  have_many :students
  have_many :exam_groups
  have_many :archived_students
  have_many(:grading_levels).conditions(is_deleted: false)
  have_many(:subjects).conditions(is_deleted: false)
  have_many(:fee_category).class_name("FinanceFeeCategory")
  have_many :elective_groups
  have_many :additional_exam_groups

  belong_to :course

  validate_presence_of :name
  validate_presence_of :start_date
  validate_presence_of :end_date

  context 'a new batch' do
    setup do
      @batch = Batch.new(:name => '2009/10')
    end
    should 'not have start date after end date' do
      @batch.start_date = Date.today
      @batch.end_date = Date.today - 1
      assert ! @batch.valid?
    end
  end

end