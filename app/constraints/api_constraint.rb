class ApiConstraint
  include ActiveModel::Validations
  attr_accessor :version

  validates :version, presence: true,
      allow_nil: false,
      numericality: { greater_than: 0 }

  def initialize(version:)
    @version = version
    raise ArgumentError.new(errors.full_messages) unless valid?
  end

  def matches?(request)
    request
    .headers
    .fetch(:accept)
    .include?("application/vnd.spotars.tracktor.v#{@version}+json")
  end
end
