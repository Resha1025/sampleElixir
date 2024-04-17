defmodule SampleElixir.Repo do
  use Ecto.Repo,
    otp_app: :sampleElixir,
    adapter: Ecto.Adapters.Postgres
end
