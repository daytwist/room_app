class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, presence: true
  validate :start_date_after_today
  validates :end_date, presence: true
  validate :end_date_after_today
  validate :end_date_after_start_date
  validates :num_of_people, presence: true, numericality: { greater_than_or_equal_to: 1 }

  private

  def start_date_after_today
    if start_date.nil?
      nil
    elsif start_date < Date.today
      errors.add(:start_date, 'を本日以降にしてください')
    end
  end

  def end_date_after_today
    if end_date.nil?
      nil
    elsif end_date < Date.today
      errors.add(:end_date, 'を本日以降にしてください')
    end
  end

  def end_date_after_start_date
    if (start_date || end_date).nil?
      nil
    elsif end_date <= start_date
      errors.add(:end_date, 'を開始日以降にしてください')
    end
  end
end
