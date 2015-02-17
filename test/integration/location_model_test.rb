require "test_helper"

describe "TestLocation" do
  describe "Build new record" do
    it "does not succeed if attributes are not valid" do
      build(:location, location: "POINT(x 50)").valid?.must_equal false
      build(:location, location: "POINT(10 x)").valid?.must_equal false
      build(:location, user_id: nil).valid?.must_equal false
      build(:location, user_id: "").valid?.must_equal false
      build(:location, user_id: "not a number").valid?.must_equal false
      build(:location, user_id: 0).valid?.must_equal false
    end
  end

  describe "Create new record" do
    it "persists a user with valid attributes" do
      create(:location).valid?.must_equal true

      # Bearing is not a mandatory attribute and will be saved as nil
      # if invalid because it gets sanitized in the model. Nil is
      # allowed for this attribute and thus valid.
      create(:location, bearing: 361).bearing.must_equal nil
      create(:location, bearing: -1).bearing.must_equal nil
      build(:location, bearing: nil).bearing.must_equal nil
      build(:location, bearing: "not a number").bearing.must_equal nil
      build(:location, bearing: "").bearing.must_equal nil
    end
  end
end
