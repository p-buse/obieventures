class Adventure < ActiveRecord::Base
	validates(:summary, presence: true, length: { minimum: 5 }, uniqueness: { case_sensitive: false })
end
