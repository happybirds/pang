class Schedule < ApplicationRecord
  enum date:{
    '周一':1,
    '周二':2,
    '周三':3,
    '周四':4,
    '周五':5,
  }
  enum address:{
    'UPEI Campus, Robertson Library 235 (Lecture)':1,
    'SDU':2,
    'Cass Hall':3,
    'Duffy Science Ctr':4,
    'Kelley Memorial': 5
  }

end
