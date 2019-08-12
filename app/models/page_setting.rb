class PageSetting < ApplicationRecord
	belongs_to :page
	belongs_to :app_setting
end
