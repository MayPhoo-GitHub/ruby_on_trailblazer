# spec/support/spec_test_helper.rb
module SpecTestHelper   
  def current_user
    User.where(email:  "admin@gmail.com").take
  end
end
