defmodule Gotcha.Factory do
  use ExMachina.Ecto, repo: Gotcha.Repo

  use Gotcha.ArenaFactory
end
