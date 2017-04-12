class Banner < ApplicationRecord

  scope :active, -> { where(active: true) }

  def color
    settings['color']
  end

  def color= color
    settings['color'] = color
  end

  def form
    settings['form']
  end

  def form= form
    settings['form'] = form
  end

end
