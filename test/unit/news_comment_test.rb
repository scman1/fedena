require File.expand_path(File.dirname(__FILE__) + './../test_helper')

class NewsCommentTest < ActiveSupport::TestCase
  validate_presence_of :author
  validate_presence_of :content
  validate_presence_of :news_id
  
  belong_to :news
  belong_to :author
end
