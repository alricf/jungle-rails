require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be created with matching password and password_confirmation fields' do
      @user = User.create(first_name: 'Bob', last_name: 'White', email: 'bobwhite@test.com', password: 'abc', password_confirmation: '123')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should be created with defined password field' do
      @user = User.create(first_name: 'James', last_name: 'Black', email: 'jamesblack@test.com', password: nil, password_confirmation: 'xyz')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should be created with defined password_confirmation field' do
      @user = User.create(first_name: 'Larry', last_name: 'Barnes', email: 'larrybarnes@test.com', password: 'xyz', password_confirmation: nil)
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should be created with a unique email field' do
      @user1 = User.create(first_name: 'Harry', last_name: 'Blue', email: 'test@test.COM', password: 'abcd', password_confirmation: 'abcd')
      @user2 = User.create(first_name: 'Henry', last_name: 'Blair', email: 'TEST@TEST.com', password: '1234', password_confirmation: '1234')
      expect(@user1).to be_valid
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should be created with defined email field' do
      @user = User.create(first_name: 'Jill', last_name: 'Brown', email: nil, password: '789', password_confirmation: '789')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should be created with defined first_name field' do
      @user = User.create(first_name: nil, last_name: 'Ross', email: 'ross@test.com', password: 'abc', password_confirmation: 'abc')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should be created with defined last_name field' do
      @user = User.create(first_name: 'Mike', last_name: nil, email: 'Mike@test.com', password: '123', password_confirmation: '123')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should be created with a minimum password length of three' do
      @user1 = User.create(first_name: 'Jane', last_name: 'Potter', email: 'jp@test.COM', password: 'abc', password_confirmation: 'abc')
      @user2 = User.create(first_name: 'Marge', last_name: 'Turner', email: 'mt@TEST.com', password: '12', password_confirmation: '12')
      expect(@user1).to be_valid
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return user if user is authenticated' do
      @user = User.new({
        first_name: 'Bill',
        last_name: 'Riley',
        email: 'br@gmail.com',
        password: '123*Testing',
        password_confirmation: '123*Testing'
      })
      @user.save!
      user = User.authenticate_with_credentials(@user.email, @user.password);
      expect(user.id).to be_present  
    end

    it 'should return nil if user is not authenticated' do
      @user = User.new({
        first_name: 'Charlie',
        last_name: 'Ray',
        email: nil,
        password: '123*Testing',
        password_confirmation: '123*Testing'
      })
      user = User.authenticate_with_credentials(@user.email, @user.password);
      expect(user).to be_nil
    end
  end
  
end
