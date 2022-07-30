# frozen_string_literal: true

require 'net/http'
require 'net/https'
require 'json'

module BRPopulate
	def self.states
    http = Net::HTTP.new('raw.githubusercontent.com', 443); 
    http.use_ssl = true
    JSON.parse http.get('/celsodantas/br_populate/master/states.json').body
	end

	def self.capital?(city, state)
		city['name'].eql?(state['capital'])
	end

	def self.populate
		states.each do |state|
			region_obj = Region.find_or_create_by(name: state['region'])
			
			state_obj = State.create({
				acronym: state['acronym'], 
				name: state['name'],
				region: region_obj
			})

			state['cities'].each do |city|
				City.create({
					name: city['name'],
					state: state_obj,
					capital: capital?(city, state)
				})
			end
		end
	end
end