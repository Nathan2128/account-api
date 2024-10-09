defmodule AccountApi.Repo do
  use Ecto.Repo,
    otp_app: :account_api,
    adapter: Ecto.Adapters.Postgres
end
