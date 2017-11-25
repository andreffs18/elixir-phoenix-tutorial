defmodule Discuss.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string
      add :user_model_id, references(:users)
      add :topic_model_id, references(:topics)

      timestamps()
    end
  end
end
