defmodule Discuss.CommentModel do
  use Discuss.Web, :model

  @derive {Poison.Encoder, only: [:content, :user_model]}

  schema "comments" do
    field :content, :string
    belongs_to :user_model, Discuss.UserModel
    belongs_to :topic_model, Discuss.TopicModel

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
