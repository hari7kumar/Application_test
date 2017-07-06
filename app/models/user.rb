class User < ActiveRecord::Base
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
	has_and_belongs_to_many :roles

	def update_roles(roles,user)
		user.roles.clear
		roles.shift
        roles.each { |i| user.roles << Role.find(i) }
	end
	def self.search(search)
	  if search
	    where('name LIKE ?', "%#{search}%")
	  end
	end
end
