# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base

  validates :moderator_id, :title, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator, class_name: :User, inverse_of: :moderated_subs 
end
