@r1 = Route.create(name: 'Charlottetown Mall Shelters to Grafton & Confederation Center',line: '1day',direction: 1)
@r2 = Route.create(name: 'Grafton & Confederation Center to Charlottetown Mall Shelters',line: '1day',direction: 2)
@r3 = Route.create(name: 'Charlottetown Mall Shelters to Grafton & Confederation Center',line: '1evening',direction: 1)
@r4 = Route.create(name: 'Grafton & Confederation Center to Charlottetown Mall Shelters',line: '1evening',direction: 2)


Board.all.each do |b|
	BoardRoute.create(board_id: b.id,route_id: @r1.id)

	BoardRoute.create(board_id: b.id,route_id: @r3.id)
end