class Page < ApplicationRecord
	has_many :page_settings
  has_many :app_settings, through: :page_settings



  after_create_commit :transfor

  def transfor
  	settings = AppSetting.all
    self.page_settings.destroy_all
    settings.each do |s|
       if self.content.include? s.name
          PageSetting.create(page_id: self.id,app_setting_id: s.id)
       end

    end
  end


end
