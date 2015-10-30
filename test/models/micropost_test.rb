require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: 'Lorem ipsum',
                                        picture: '/test/fixtures/rails.png')
  end

  test 'should be valid' do
    assert @micropost.valid?
  end

  test 'user id should be present' do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test 'content should be present' do
    @micropost.content = '   '
    assert_not @micropost.valid?
  end

  test 'content should be at most 140 characters' do
    @micropost.content = 'a' * 141
    assert_not @micropost.valid?
  end

  test 'size should be at most 5 megabytes' do
    @micropost.picture.extend PictureStub
    assert_not @micropost.valid?
  end

  test 'order should be most recent first' do
    assert_equal microposts(:most_recent), Micropost.first
  end

  module PictureStub
    def size
      6.megabytes
    end
  end
end
