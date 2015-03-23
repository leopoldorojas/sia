module LocationsHelper

	# Returns a dynamic path based on the provided parameters
	def sti_location_path(type = "location", location = nil, action = nil)
	  send "#{format_sti(action, type, location)}_path", location
	end

	def format_sti(action, type, location)
	  action || location ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
	end

	def format_action(action)
	  action ? "#{action}_" : ""
	end

end
