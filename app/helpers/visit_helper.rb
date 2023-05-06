module VisitHelper
    def domain url
        uri = URI.parse(url).host
        PublicSuffix.parse(uri).domain
    end
end
