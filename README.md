# OmniAuth Datadog

## Installation

```ruby
gem 'omniauth-datadog'
```

## Basic Usage

```ruby
use OmniAuth::Builder do
  provider :datadog,
    ENV['DATADOG_ID'],
    ENV['DATADOG_SECRET'],
    scope: 'api_keys_write'
end
```


## Basic Usage Rails

In `config/initializers/datadog.rb`

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :datadog,
    Rails.application.credentials.omniauth[:datadog][:id],
    Rails.application.credentials.omniauth[:datadog][:secret],
    scope: 'api_keys_write <other_scope>'
end
```
