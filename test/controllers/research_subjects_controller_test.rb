require 'test_helper'

class ResearchSubjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @research_subject = research_subjects(:one)
  end

  test "should get index" do
    get research_subjects_url, as: :json
    assert_response :success
  end

  test "should create research_subject" do
    assert_difference('ResearchSubject.count') do
      post research_subjects_url, params: { research_subject: { name: @research_subject.name } }, as: :json
    end

    assert_response 201
  end

  test "should show research_subject" do
    get research_subject_url(@research_subject), as: :json
    assert_response :success
  end

  test "should update research_subject" do
    patch research_subject_url(@research_subject), params: { research_subject: { name: @research_subject.name } }, as: :json
    assert_response 200
  end

  test "should destroy research_subject" do
    assert_difference('ResearchSubject.count', -1) do
      delete research_subject_url(@research_subject), as: :json
    end

    assert_response 204
  end
end
