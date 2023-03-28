require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save a product when all four fields are defined' do
      @category1 = Category.create(name: 'Trees')
      @category2 = Category.create(name: 'Shrubs')
      @category3 = Category.create(name: 'Evergreens')
      @product = Product.create(name: 'Mango Tree', price_cents: 5000, quantity: 5, category_id: @category1.id)
      expect(@product.name).to eql('Mango Tree')
      expect(@product.price_cents).to eql(5000)
      expect(@product.quantity).to eql(5)
      expect(@product.category_id).to eql(@category1.id)
    end

    it 'should validate the presence of name' do
      @category1 = Category.create(name: 'Trees')
      @category2 = Category.create(name: 'Shrubs')
      @category3 = Category.create(name: 'Evergreens')
      @product = Product.create(name: nil, price_cents: 6000, quantity: 6, category_id: @category2.id)
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should validate the presence of price' do
      @category1 = Category.create(name: 'Trees')
      @category2 = Category.create(name: 'Shrubs')
      @category3 = Category.create(name: 'Evergreens')
      @product = Product.create(name: 'Pine', price_cents: nil, quantity: 7, category_id: @category3.id)
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should validate the presence of quantity' do
      @category1 = Category.create(name: 'Trees')
      @category2 = Category.create(name: 'Shrubs')
      @category3 = Category.create(name: 'Evergreens')
      @product = Product.create(name: 'Pistachio', price_cents: 8000, quantity: nil, category_id: @category2.id)
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should validate the presence of category' do
      @category1 = Category.create(name: 'Trees')
      @category2 = Category.create(name: 'Shrubs')
      @category3 = Category.create(name: 'Evergreens')
      @product = Product.create(name: 'Red Raspberry', price_cents: 9000, quantity: 9, category_id: nil)
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
