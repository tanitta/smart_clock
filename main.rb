#! /bin/sh
exec ruby -S -x "$0" "$@"
#! ruby

class Schedule < Struct.new(:h,:min,:type)
	def follow?(time)
		time.hour == h && time.min == min
	end
end

class ScheduleBook < Struct.new(:schedules)
	def follow_schedules(time)
		schedules.select{|schedule|
			schedule.follow?(time)
		}
	end
end

class SmartClock < Struct.new(:schedule_book)
	def run(now_time)
		schedule_book.follow_schedules(now_time).each{|schedule|
			p schedule
			ring(schedule)
		}
	end
	
	def ring(schedule)
		if schedule.type == :start
			3.times{system("mpg321 /home/tanitta/Music/alarm1.mp3")}
		end
		#
		if schedule.type == :end
			3.times{system("mpg321 /home/tanitta/Music/alarm2.mp3")}
		end
	end
end

schedule_book = ScheduleBook.new([
	Schedule.new(10, 0, :start),
	Schedule.new(10, 45, :end),
	
	Schedule.new(11, 0, :start),
	Schedule.new(11, 45, :end),
	
	Schedule.new(12, 0, :start),
	Schedule.new(12, 45, :end),
	
	Schedule.new(13, 0, :start),
	Schedule.new(13, 45, :end),
	
	Schedule.new(14, 0, :start),
	Schedule.new(14, 45, :end),
	
	Schedule.new(15, 0, :start),
	Schedule.new(15, 45, :end),
	
	Schedule.new(16, 0, :start),
	Schedule.new(16, 45, :end),
	
	Schedule.new(17, 0, :start),
	Schedule.new(17, 45, :end),
	
	Schedule.new(18, 0, :start),
	Schedule.new(18, 45, :end),
	
	Schedule.new(19, 0, :start),
	Schedule.new(19, 45, :end),
	
	Schedule.new(20, 0, :start),
	Schedule.new(20, 45, :end),
	
	Schedule.new(21, 0, :start),
	Schedule.new(21, 45, :end),
	
	Schedule.new(22, 0, :start),
	Schedule.new(22, 45, :end),
])

SmartClock.new(schedule_book).run(Time.now)

