require 'test_helper'

class ResearchGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @research_group = research_groups(:one)
  end

  test "should get index" do
    get research_groups_url, as: :json
    assert_response :success
  end

  test "should create research_group" do
    assert_difference('ResearchGroup.count') do
      post research_groups_url, params: { research_group: { classification: @research_group.classification, date_classification: @research_group.date_classification, description: @research_group.description, foundation_date: @research_group.foundation_date, name: @research_group.name, research_priorities: @research_group.research_priorities, strategic_focus: @research_group.strategic_focus, url: @research_group.url } }, as: :json
    end

    assert_response 201
  end

  test "should show research_group" do
    get research_group_url(@research_group), as: :json
    assert_response :success
  end

  test "should update research_group" do
    patch research_group_url(@research_group), params: { research_group: { classification: @research_group.classification, date_classification: @research_group.date_classification, description: @research_group.description, foundation_date: @research_group.foundation_date, name: @research_group.name, research_priorities: @research_group.research_priorities, strategic_focus: @research_group.strategic_focus, url: @research_group.url } }, as: :json
    assert_response 200
  end

  test "should destroy research_group" do
    assert_difference('ResearchGroup.count', -1) do
      delete research_group_url(@research_group), as: :json
    end

    assert_response 204
  end
end
