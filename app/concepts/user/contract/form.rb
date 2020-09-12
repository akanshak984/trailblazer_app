module User::Contract
  class Form < Reform::Form
    property :name
    property :email
    property :password
    property :mobile_number

    validates_uniqueness_of :email
    validates :email, :name, :password, :mobile_number, presence: :true
  end
end