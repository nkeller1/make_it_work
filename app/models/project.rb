class Project <ApplicationRecord
  validates_presence_of :name, :material
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects
  belongs_to :challenge

  def self.average_age
    contestants.average(:age)
  end
end
