require 'test_helper'

class ElectiveGroupTest < ActiveSupport::TestCase

  include FactoryGirl::Syntax::Methods

  belong_to :batch
  have_many :subjects

  validate_presence_of :name
  validate_presence_of :batch_id

  #have_named_scope :for_batch

  context "existing elective group" do

    setup do
      @elective_group = build(:elective_group)
    end

    should 'be new a active new record' do
      assert !@elective_group.is_deleted
      assert @elective_group.new_record?
    end


    should ' be disabled' do
      @elective_group.inactivate
      assert @elective_group.is_deleted
    end


  end

end
