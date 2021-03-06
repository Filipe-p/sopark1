class User < ApplicationRecord
  # after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  has_many :cars, dependent: :destroy
  has_many :spaces, dependent: :destroy

  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  devise :omniauthable, omniauth_providers: [:facebook]

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      # skip confirmation for devise if user comes from provider that confirms emails
      user.skip_confirmation!
      user.save
    end

    return user
  end

  private

  #this is what sends the email in the begining of this model and connects the model to the email through the UserMailer
  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end

