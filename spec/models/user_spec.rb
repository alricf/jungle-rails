require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:each) do
      @user = User.create(
        first_name: 'Bob', 
        last_name: 'Robson', 
        email: 'test@test.com', 
        password: 'abc', 
        password_confirmation: 'abc')
    end

    it 'should be created with matching password and password_confirmation fields' do
      @user.password_confirmation = '123'
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should be created with defined password field' do
      @user.password = nil
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should be created with defined password_confirmation field' do
      @user.password_confirmation = nil
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should be created with a unique email field' do
      @user2 = User.create(first_name: 'Henry', last_name: 'Blair', email: 'TEST@TEST.com', password: '1234', password_confirmation: '1234')
      expect(@user).to be_valid
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should be created with defined email field' do
      @user.email = nil
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should be created with defined first_name field' do
      @user.first_name = nil
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should be created with defined last_name field' do
      @user.last_name = nil
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should be created with a minimum password length of three' do
      @user2 = User.create(first_name: 'Marge', last_name: 'Turner', email: 'mt@TEST.com', password: '12', password_confirmation: '12')
      expect(@user).to be_valid
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(
        first_name: 'Bill',
        last_name: 'Riley',
        email: 'br@gmail.com',
        password: '123*Testing',
        password_confirmation: '123*Testing'
      )
    end

    it 'should return user if user is authenticated' do
      user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(user).to be_present
    end

    it 'should return nil if user is not authenticated' do
      @user.email = ''
      @user.save
      user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(user).to be_nil
    end

    it 'should authenticate successfully if a visitor types in a few spaces before and/or after their email address' do
      email = ' br@gmail.com '
      user = User.authenticate_with_credentials(email, @user.password)
      expect(user).to eql(@user)
      expect(user.email).to eql('br@gmail.com')
      expect(user).to be_present
    end

    it 'should authenticate if a visitor types in the wrong case for their email' do
      @user.email = 'eXample@domain.COM'
      @user.save
      email = 'EXAMPLe@DOMAIN.CoM'
      expect(@user).to be_valid
      user = User.authenticate_with_credentials(email, @user.password)
      expect(user).to be_present
    end

  end
  
end
