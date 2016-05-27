Rails.application.routes.draw do
  mount V1::Pictures => '/api'
  mount V1::Users => '/api'
  mount V1::Messages => '/api'
end


