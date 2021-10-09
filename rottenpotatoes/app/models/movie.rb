class Movie < ActiveRecord::Base
#     def self.all_ratings
#         arr = Array.new
#         self.select("rating").uniq.each {|r| arr.push(r.rating)}
#         arr.sort
#     end

    def self.all_ratings
        ['G','PG','PG-13','R','NC-17']
    end

    def self.with_director(director)
        Movie.where(director: director)
    end
end
