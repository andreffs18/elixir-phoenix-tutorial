defmodule Discuss.Repo.Migrations.AddUserModelIdToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      remove :user_id
      add :user_model_id, references(:users)
    end
  end

end
