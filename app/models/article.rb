class Article < ApplicationRecord
  mount_uploader :icon, ImageUploader
  default_scope->{order('created_at desc')}
  enum catalog:{
    '小胖日常':0,
    '碎碎念':1
  }
end
