class Board < ApplicationRecord

	enum route_num:{
		'1day':1,
		'2day':2,
		'3day':3,
		'1evening':12
	}


end
