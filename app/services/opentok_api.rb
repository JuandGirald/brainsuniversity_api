class OpentokApi
	require "opentok"

	def initialize
		@opentok = opentok
	end

	# create a room session with opentok and return the id
	def create_session
		opentok.create_session
	end

	def get_user_token(user, schedule, sesion_id)
		opentok.generate_token(sesion_id, {
	    :role        => :publisher,
	    :expire_time => Time.now.to_i + 10.minutes + schedule.duration.to_i.minutes,
	    :data        => "name=#{user.first_name}"
		});
	end

	private
		# connect to the opentok api
		def opentok
			OpenTok::OpenTok.new ENV['OPENTOK_API_KEY'], ENV['OPENTOK_SECRET']	
		end
		
end