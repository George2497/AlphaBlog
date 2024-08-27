require 'test_helper'

class SigningUpAUser < ActionDispatch::IntegrationTest

  test "sign up as an admin user" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {username: "johndoe", email: "johndoe@exmaple.com", password: "password", admin: false } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'johndoe', response.body
  end

  test "sign up as a rejected user" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: {username: "jo", email: "johndoe@exmaple.com", password: "password", admin: false } }
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
