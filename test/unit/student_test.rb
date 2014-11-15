require File.expand_path(File.dirname(__FILE__) + './../test_helper')

class StudentTest < ActiveSupport::TestCase

  include FactoryGirl::Syntax::Methods

  belong_to :batch
  belong_to :student_category
  belong_to :country
  belong_to :nationality
  have_many :guardians
  have_many :finance_transactions
  
  context 'a new student' do
    setup { @student = build(:student) }

    should 'be new record' do
      assert @student.new_record?
    end

    should 'be valid' do
      assert @student.valid?
    end

#    should 'validate presence of admission no' do
#      @student.admission_no = nil
#      assert !@student.valid?
#      assert @student.errors[:admission_no].any
#    end

    should 'validate presence of admission date' do
      @student.admission_date = nil
      assert !@student.valid?
      assert @student.errors[:admission_date].any?
    end

    should 'validate presence of first name' do
      @student.first_name = nil
      assert !@student.valid?
      assert @student.errors[:first_name].any?
    end

    should 'validate presence of batch' do
      @student.batch_id = nil
      assert !@student.valid?
      assert @student.errors[:batch_id].any?
    end

    should 'validate presence of date of birth' do
      @student.date_of_birth = nil
      assert !@student.valid?
      assert @student.errors[:date_of_birth].any?
    end

    should 'not have date of birth in future' do
      @student.date_of_birth = Date.today
      assert !@student.valid?
      assert @student.errors[:date_of_birth].any?
    end

    should 'validate presence of gender attribute' do
      @student.gender = nil
      assert !@student.valid?
      assert @student.errors[:gender].any?
    end

    should 'return correct first and last names' do
      assert @student.first_and_last_name == 'John Doe'
    end

    should 'return correct full name' do
      assert @student.full_name == 'John K Doe'
    end

    should 'return correct gender as text' do
      assert @student.gender_as_text == 'Male'
      @student.gender = 'f'
      assert @student.gender_as_text == 'Female'
    end

    should 'accept m as gender attribute' do
      @student.gender = 'm'
      assert @student.valid?
      assert @student.gender_as_text == 'Male'
    end

    should 'accept M as gender attribute' do
      @student.gender = 'M'
      assert @student.valid?
      assert @student.gender_as_text == 'Male'
    end

    should 'accept f as gender attribute' do
      @student.gender = 'f'
      assert @student.valid?
      assert @student.gender_as_text == 'Female'
    end

    should 'accept F as gender attribute' do
      @student.gender = 'F'
      assert @student.valid?
      assert @student.gender_as_text == 'Female'
    end

    should 'not accept invalid gender attributes' do
      @student.gender = 'qwerty'
      assert !@student.valid?
      assert @student.errors[:gender].any?
    end

  end

  context 'saving a new user' do
    setup do
      @student = build(:student)
    end

    should 'save the record successfully' do
      assert @student.save
    end
    
  end

  context 'destroying a student record' do
    setup do
      @student = create(:student)
      @guardian = create(:guardian)
      @student.guardians << @guardian
    end

    should 'destroy guardians records also' do
      @student.destroy
      assert ! Guardian.exists?(@guardian.id)
    end
  end
  
end