module AdminArea
  extend ActiveSupport::Concern

  included do
    before_action do
      authorize! :enter, :admin
    end

    # layout 'admin'
  end

end
