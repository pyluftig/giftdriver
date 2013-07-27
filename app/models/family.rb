class Family < ActiveRecord::Base
  has_many :family_members
  validates :code, :presence => :true
  belongs_to :drive
  attr_accessible :code, :drop_location
  belongs_to :drop_location
  belongs_to :user


  attr_accessible :drop_locations_attributes, :users_attributes
  accepts_nested_attributes_for :drop_location
  accepts_nested_attributes_for :user
  
  def adopted?
    self.adopted_by != nil
  end

  def get_adopter_email
    user = User.find(self.adopted_by)
    user.email
  end

  def get_adopter_name
    user = User.find(self.adopted_by)
    user.full_name
  end

  def get_adopter_address
    user = User.find(self.adopted_by)
    "#{user.street}, #{user.city}, #{user.state}, #{user.zipcode}"
  end

  def get_adopter_phone
    user = User.find(self.adopted_by)
    user.phone
  end

   def get_adopter_company
    user = User.find(self.adopted_by)
    user.company ? user.company : "n/a"
  end

  def self.not_adopted_families(drive)
    Drive.find(drive).families.where('adopted_by IS NULL')
  end

  def self.adopted_families(drive)
    Drive.find(drive).families.where('adopted_by IS NOT NULL')
  end

  def members_names_sentence
    names = self.family_members.map { |member| member.first_name }
    names.to_sentence
  end

  def sampled_needs(total_needs)
    need_objects = self.family_members.map { |person| person.needs }
    need_strings = []
    need_objects.each { |x| x.each { |y| need_strings << y.text } }
    need_strings.sample(total_needs)
  end

end
