defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  alias Discuss.{TopicModel, CommentModel}

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = TopicModel
    |> Repo.get(topic_id)
    |> Repo.preload(comments: [:user_model])

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    topic = socket.assigns.topic
    user_id = socket.assigns.user_model_id
    changeset = topic
    |> build_assoc(:comments, user_model_id: user_id)
    |> CommentModel.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        comment = Repo.preload(comment, :user_model)
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

end
