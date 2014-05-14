class Post < ActiveRecord::Base
  validates_presence_of :title, :body, :category
  belongs_to :category
  belongs_to :user
  acts_as_taggable
  acts_as_taggable_on :tags
  self.per_page = 10
  acts_as_votable
  acts_as_punchable
  
  scope :published, where(:published => true)
  scope :unpublished, where(:published => false)
  scope :pinned, where(:pinned => true)
  
  def self.text_search(search)
    if search.present?
      where("title @@ :q or body @@ :q", q: search)
    else
      scoped
    end
  end
end