require 'test_helper'

class CreateNewArticle < ActionDispatch::IntegrationTest

  setup do
    @user = User.create(username: 'test', email: "test@example.com", password: "password", admin: false)
    sign_in_as(@user)
  end

  test "should create a new article" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: {title: "test article", description: "test description", category: "Travel"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'test article', response.body
  end

  test "should not create a new article" do
    get "/articles/new"
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: {title: "", description: "test description", category: "Travel"} }
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
