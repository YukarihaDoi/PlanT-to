require "test_helper"

class Public::QuestionPostImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_question_post_images_show_url
    assert_response :success
  end

  test "should get index" do
    get public_question_post_images_index_url
    assert_response :success
  end

  test "should get create" do
    get public_question_post_images_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_question_post_images_destroy_url
    assert_response :success
  end
end
