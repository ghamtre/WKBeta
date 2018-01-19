require 'test_helper'

class SkillControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get skill_index_url
    assert_response :success
  end

  test "should get new" do
    get skill_new_url
    assert_response :success
  end

  test "should get create" do
    get skill_create_url
    assert_response :success
  end

  test "should get listing" do
    get skill_listing_url
    assert_response :success
  end

  test "should get pricing" do
    get skill_pricing_url
    assert_response :success
  end

  test "should get description" do
    get skill_description_url
    assert_response :success
  end

  test "should get photo_upload" do
    get skill_photo_upload_url
    assert_response :success
  end

  test "should get perks" do
    get skill_perks_url
    assert_response :success
  end

  test "should get location" do
    get skill_location_url
    assert_response :success
  end

  test "should get update" do
    get skill_update_url
    assert_response :success
  end

end
