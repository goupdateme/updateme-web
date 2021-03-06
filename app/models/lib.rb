class Lib < ActiveRecord::Base
  Types = [
    Libs::RubyGem,
    Libs::JsPackage,
    Libs::PythonPackage,
    Libs::GithubRepo,
    Libs::RustCrate
  ].freeze

  Slugs = Types.map do |type|
    type.to_s.demodulize.underscore.dasherize
  end.freeze

  SlugMap = Slugs.zip(Types).to_h.freeze

  validates_uniqueness_of :name, scope: :type

  def scout(options = {})
    self.class::SCOUT.perform(self, **options)
  end

  def active_model_serializer
    LibSerializer
  end
end
