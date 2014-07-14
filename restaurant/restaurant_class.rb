class Restaurant
	def initialize(name,address,health_score)
		@name = name
		@address = address
		@health_score = health_score
		@favorite_meals = []
	end
	def add_fav_meal(person,appetizer,entree,dessert)
		@favorite_meals << {
			:person => person,
			:appetizer => appetizer,
			:entree => entree,
			:dessert => dessert
		}
	end
end