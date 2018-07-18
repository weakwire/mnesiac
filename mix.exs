defmodule Mnesiac.MixProject do
  @moduledoc false
  use Mix.Project

  def project do
    [
      app: :mnesiac,
      version: "0.1.0",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      dialyzer: [plt_add_deps: :transitive],
      start_permanent: Mix.env() == :prod,
      package: [
        description: "Autoclustering for mnesia made easy!",
        files: ["lib", ".formatter.exs", "mix.exs", "README.md", "LICENSE", "CHANGELOG.md"],
        maintainers: ["beardedeagle"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/beardedeagle/mnesiac"}
      ],
      aliases: [
        check: ["format", "compile --force", "credo --strict --all"],
        test: "coveralls.html --trace --slowest 10"
      ],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :mnesia],
      mod: {Mnesiac.Application, []}
    ]
  end

  defp elixirc_paths(env) when env in [:dev, :test], do: ["lib", "test/support"]
  defp elixirc_paths(_env), do: ["lib"]

  defp deps do
    [
      {:libcluster, "~> 3.0.2", optional: true},
      {:credo, "~> 0.9", only: [:dev], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.3", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.18", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.9", only: [:dev, :test], runtime: false}
    ]
  end
end