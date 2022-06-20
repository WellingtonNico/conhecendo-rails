

class Book < ApplicationRecord
  include ImageSaver
  belongs_to :person
  validates :title, presence: true, length: { maximum: 100 }
  validates :published_at, presence: true
  validates :text, presence: true
  validates :value, presence: true, numericality: { less_than_or_equal_to: 99999999.99 }
  validates :person, presence: true
  has_and_belongs_to_many :categories
  has_one :image, dependent: :destroy, as: :imageable
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :people, -> {distinct}, through: :orders

  SoldOutException   = Class.new(StandardError)
  NotEnoughException = Class.new(StandardError)

  def sell(qty = 1)
    raise SoldOutException,   'Esgotado'       if sold_out?
    raise NotEnoughException, 'Sem estoque suficiente' if self.stock - qty < 0
    self.stock -= qty
    save!
  end


  def sold_out?
    stock<1
  end

  def self.search(term)
    where("title like ?","%#{term}")
  end

end
