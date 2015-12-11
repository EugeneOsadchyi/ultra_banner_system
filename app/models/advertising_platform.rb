class AdvertisingPlatform < ActiveRecord::Base
  has_many :banners, dependent: :destroy

  before_validation :set_platform_name #TODO before_save not works. Need better solution

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :platform_name, presence: true
  validates :url, presence: true, url: true

  def active?
    self.active
  end

  def relevant_banner
    self.banners.for_rotation.first
  end

  private
  def set_platform_name
    self.platform_name = self.name.parameterize('_') if self.name
  end
end
