defmodule Gotcha.Factory do
  use ExMachina.Ecto, repo: Gotcha.Repo

  use Gotcha.ArenaFactory
  use Gotcha.PlayerFactory
  use Gotcha.ArenaPlayerFactory
end
