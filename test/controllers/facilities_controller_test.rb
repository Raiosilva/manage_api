require 'test_helper'

class FacilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @facility = facilities(:one)
  end

  test "should get index" do
    get facilities_url, as: :json
    assert_response :success
  end

  test "should create facility" do
    assert_difference('Facility.count') do
      post facilities_url, params: { facility: { address: @facility.address, city: @facility.city, complement: @facility.complement, country: @facility.country, customer_id: @facility.customer_id, number: @facility.number, state: @facility.state, zipCode: @facility.zipCode } }, as: :json
    end

    assert_response 201
  end

  test "should show facility" do
    get facility_url(@facility), as: :json
    assert_response :success
  end

  test "should update facility" do
    patch facility_url(@facility), params: { facility: { address: @facility.address, city: @facility.city, complement: @facility.complement, country: @facility.country, customer_id: @facility.customer_id, number: @facility.number, state: @facility.state, zipCode: @facility.zipCode } }, as: :json
    assert_response 200
  end

  test "should destroy facility" do
    assert_difference('Facility.count', -1) do
      delete facility_url(@facility), as: :json
    end

    assert_response 204
  end
end
