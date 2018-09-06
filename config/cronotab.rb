# cronotab.rb — Crono configuration file
#
# Here you can specify periodic jobs and schedule.
# You can use ActiveJob's jobs from `app/jobs/`
# You can use any class. The only requirement is that
# class should have a method `perform` without arguments.
#
# class TestJob
#   def perform
#     puts 'Test!'
#   end
# end
#
# Crono.perform(TestJob).every 2.days, at: '15:30'
#


Crono.perform(Route1daydir1Job).every 5.seconds
Crono.perform(Route1daydir2Job).every 5.seconds

# Crono.perform(Route1eveningdir1Job).every 5.seconds
# Crono.perform(Route1eveningdir2Job).every 5.seconds
