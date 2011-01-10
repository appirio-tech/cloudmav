# Sunspot.session = Sunspot::Rails.build_session
# ActionController::Base.module_eval { include(Sunspot::Rails::RequestLifecycle) }

Sunspot.setup(Talk) do
  text :title
  text :description
end