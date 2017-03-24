class Identity < ActiveRecord::Base

  belongs_to :user

  accepts_nested_attributes_for :user

  validates :uid, uniqueness: { scope: :provider }


  def self.from_omniauth params
    attrs = {
      provider: params[:provider],
      uid: params[:uid],
      user_attributes: {
        email: params[:info]['email'],
        profile: profile_from(params)
      }
    }
    new attrs
  end

  def self.profile_from params
    send("profile_from_#{ params[:provider] }", params)
  end


  protected

  def self.profile_from_facebook params
    firstname, lastname = params[:info]['name'].split(' ')
    {
      firstname: firstname,
      lastname: lastname,
      location: params[:info]['location'],
      image: params[:info]['image']
    }
  end

  def self.profile_from_vkontakte params
    {
      firstname: params[:info]['first_name'],
      lastname: params[:info]['last_name'],
      location: params[:info]['location'],
      image: params[:extra]['raw_info']['photo_200_orig'],
      birthdate: params[:extra]['raw_info']['bdate']
    }
  end

end
