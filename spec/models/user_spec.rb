require "rails_helper"

RSpec.describe User, type: :model do
  subject{
    User.new(
      name: "test user",
      email: "test@gmail.com",
      password: "mayphoowai",
      password_confirmation: "mayphoowai",
      phone: "00401245003",
      address: "Ygn",
      super_user_flag: true,
      birthday: "1998-9-3"
    )
  }

  it "ensures name presence" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it "ensures email presence" do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  it "ensures password presence" do
    subject.password = nil
    expect(subject).to_not be_valid
  end
  it "ensures password_confirmation presence" do
    subject.password_confirmation = nil
    expect(subject).to_not be_valid
  end
  it "ensures super_user_flag presence" do
    subject.super_user_flag = nil
    expect(subject).to_not be_valid
  end
  it "should save successfully" do
    expect(subject).to be_valid
  end
  it "is not valid. Name is too long." do
    subject.name = 'a' * 101
    expect(subject).to_not be_valid
  end
  it "is not valid. Wrong email format" do
    subject.email = "wrongemail"
    expect(subject).to_not be_valid
  end
  it "is not valid. Password doesn't match password confirmation" do
    subject.password = "password"
    expect(subject).to_not be_valid
  end
  it "is not valid. Phone must be numeric" do
    subject.phone = 'phone_text'
    expect(subject).to_not be_valid
  end

  it "is not valid. Phone is too short" do
    subject.phone = "0999999"
    expect(subject).to_not be_valid
  end

  it "is not valid. Phone is too long" do
    subject.phone = "09999999999999"
    expect(subject).to_not be_valid
  end

  it "is not valid. Address is too long" do
    subject.address = "a" * 256
    expect(subject).to_not be_valid
  end

end
