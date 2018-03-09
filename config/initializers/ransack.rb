# require 'action_view'

# include ActionView::Helpers::AssetTagHelper

Ransack.configure do |c|
  c.custom_arrows = {
    default_arrow: "<i class='fa fa-sort' aria-hidden='true'></i>"
  }
end
