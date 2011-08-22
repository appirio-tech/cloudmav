module Virgil
  class Railtie < Rails::Railtie
    initializer "virgil.assign_guidance_file" do
      Virgil::Config.guidance_definitions = Pathname.new("#{Rails.root}/lib/guidance.rb")
    end

    config.to_prepare do
      Virgil::Config.guidance_definitions = Pathname.new("#{Rails.root}/lib/guidance.rb")
      Virgil::Dsl.class_eval(File.read(Virgil::Config.guidance_definitions))
    end
  end
end