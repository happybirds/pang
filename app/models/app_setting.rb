class AppSetting < ApplicationRecord
	has_many :page_settings
  has_many :pages, through: :page_settings

  validates :name , uniqueness: true

end
