
Crono.perform(Route1daydir1Job).every 10.seconds
Crono.perform(Route1daydir2Job).every 10.seconds

Crono.perform(Route2daydir1Job).every 10.seconds
Crono.perform(Route3daydir1Job).every 10.seconds

Crono.perform(Route1eveningdir1Job).every 15.seconds
Crono.perform(Route1eveningdir2Job).every 15.seconds
#
#
Crono.perform(DeleteRedisJob).every 1.days, at: '00:00'


Crono.perform(ClearlogJob).every 20.minutes
