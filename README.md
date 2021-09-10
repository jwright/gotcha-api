Gotcha! API
===========

The Elixir Phoenix API for playing Gotcha! Gotcha. Gotcha where I want cha.

## DESCRIPTION

This is the code for the server-side API application for the Gotcha game. It is built using [Absinthe](http://absinthe-graphql.org/) and it is powers the Gotcha React Native application.

## INSTALLATION

This project was created using [Elixir](https://elixir-lang.org/), [Phoenix](https://phoenixframework.org/), and [Absinthe](http://absinthe-graphql.org/).

There are a few pre-requisites that you need to get started.

```
brew install node
brew install elixir
brew install postgresql
brew services start postgresql
mix archive.install hex phx_new 1.5.12
```

Then clone or fork this repo.

```
git clone https://github.com/jwright/gotcha-api.git
```

Get the dependencies

```
cd gotcha-api
mix deps.get
```

Setup the database

```
mix ecto.setup
```

## RUNNING

You can run the Phoenix server with the following:

```
mix phx.server
```

The application will run on port `4000` by default so you can access the web app at `http://localhost:4000`.

### Running Tests

[ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html) is the test framework that was used for this application.

To run all of the tests for this application, you can run the following within the root directory.

```
mix test
```

## CONTRIBUTING

1. Fork the repository `hub fork https://github.com/jwright/gotcha-api.git`
1. Create a feature branch `git checkout -b my-awesome-feature`
1. Codez!
1. Commit your changes (small commits please)
1. Push your new branch `git push origin my-awesome-feature`
1. Create a merge request `hub pull-request -b jwright:master -h <your-account>:my-awesome-feature`
