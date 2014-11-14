require File.expand_path(File.dirname(__FILE__) + './../test_helper')

class SubjectTest < ActiveSupport::TestCase

  include FactoryGirl::Syntax::Methods
  
  validate_presence_of :name
  validate_presence_of :code
  validate_presence_of :max_weekly_classes
  validate_presence_of :batch_id
  validate_numericality_of :max_weekly_classes
  belong_to :batch
  belong_to :elective_group
  have_many :timetable_entries
  have_many :employees_subjects
  
  context 'new general subject' do

    setup do
      @subject = build(:general_subject)
    end

    should 'be a new record' do
      assert @subject.new_record?
    end

    should 'create a subject without exam' do
      @subject.batch_id = 1
      @subject.no_exams = true
      assert_valid @subject
    end

    should 'not create a subject with same code' do
      @subject = create(:general_subject)
      @subject2 = build(:general_subject)
      assert_invalid @subject2
      assert @subject2.errors[:code].any?
    end

    should 'save with valid data' do
      @subject = build(:general_subject)
      @subject.save
      assert_equal Subject.count, 1
    end

    should 'be disabled' do
      @subject.inactivate
      assert @subject.is_deleted
    end

  end

end