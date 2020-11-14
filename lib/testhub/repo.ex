defmodule Testhub.Repo do
  use Ecto.Repo,
    otp_app: :testhub,
    adapter: Ecto.Adapters.Postgres
end
