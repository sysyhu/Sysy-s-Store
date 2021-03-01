require 'test_helper'

class Admin::ProductImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_product_images_index_url
    assert_response :success
  end

end
