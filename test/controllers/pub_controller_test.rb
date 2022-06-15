require 'test_helper'

class PubControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success
    assert_select 'h1', 'Título do layout público'
    assert_routing({path: root_path},{controller: 'pub',action: 'index'})
  end

  test "should get sobre" do
    get pub_sobre_url
    assert_response :success
  end

end
