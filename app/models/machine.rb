class Machine < ApplicationRecord
  include ActionView::Helpers::TextHelper

  validates_presence_of :location

  belongs_to :owner
  has_many :machine_snacks
  has_many :snacks, through: :machine_snacks

  def average_price
    snacks.average(:price)
  end

  def snack_count
    snacks.count
  end

  def unique_snacks
    snacks.distinct
  end

  def snack_count_words
    pluralize(unique_snacks.count, "kind")
  end
end
