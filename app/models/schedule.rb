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
    'UPEI Campus, Duffy Research Ctr 212 (Lecture)':2,
    'UPEI Campus, Cass Science Hall 104 (Lab)':3
   
  }

end
