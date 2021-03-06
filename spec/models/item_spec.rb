require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { FactoryBot.create(:user) }
  before do
    @item = FactoryBot.build(:item, user_id: user.id)
  end

  context 'itemが出品できる場合' do
    it '全ての値が正常であれば出品できる' do
      expect(@item).to be_valid
    end
  end
  context 'itemが出品できないとき' do
    it 'imageが空では出品できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it '商品にuserが紐付いていない場合は出品できない' do
      @item.user_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
    it 'item_nameが空では出品できない' do
      @item.item_name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Item name can't be blank")
    end
    it 'explanationが空では出品できない' do
      @item.explanation = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Explanation can't be blank")
    end
    it 'category_idが1では出品できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end
    it 'status_idが1では出品できない' do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Status must be other than 1')
    end
    it 'shipping_area_idが1では出品できない' do
      @item.shipping_area_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping area must be other than 1')
    end
    it 'days_to_ship_idが1では出品できない' do
      @item.days_to_ship_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Days to ship must be other than 1')
    end
    it 'priceが300¥以下では出品できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than 299')
    end
    it 'priceが¥9,999,999以上では出品できない' do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than 10000000')
    end
    it 'priceが半角数字出なければ出品できない' do
      @item.price = '３００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
    it 'priceが半角英数混合では登録できない' do
      @item.price = '1a2b3c'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
    it 'priceが半角英語だけでは登録できないこと' do
      @item.price = 'abcde'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
  end
end
