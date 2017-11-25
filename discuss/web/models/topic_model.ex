defmodule Discuss.TopicModel do
  use Discuss.Web, :model
  use Ecto.Schema

  schema "topics" do
    field :title, :string

    has_many :comments, Discuss.CommentModel
    belongs_to :user_model, Discuss.UserModel
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
