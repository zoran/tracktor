class ApiSubDomainConstraint
  def initialize(sub_domain)
    @sub_domains = [sub_domain].flatten
  end

  def matches?(request)
    @sub_domains.include? request.subdomain
  end
end
