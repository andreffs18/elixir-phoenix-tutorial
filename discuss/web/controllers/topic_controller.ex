defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.TopicModel


  def index(conn, params) do
    topics = Repo.all(TopicModel)
    IO.inspect(conn.assigns)
    render conn, "index.html", topics: topics
  end


  def new(conn, _params) do
    changeset = TopicModel.changeset(%TopicModel{}, %{})

    render conn, "new.html", changeset: changeset
  end


  def create(conn, %{"topic_model" => topic_model}) do
    changeset = TopicModel.changeset(%TopicModel{}, topic_model)

    case Repo.insert changeset do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created!")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:warning, "There was a problem with saving this topic.")
        |> render("new.html", changeset: changeset)
    end
  end


  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(TopicModel, topic_id)
    changeset = TopicModel.changeset(topic)
    render conn, "edit.html", changeset: changeset, topic: topic
  end


  def update(conn, %{"id" => topic_id, "topic_model" => topic}) do
    old_topic = Repo.get(TopicModel, topic_id)
    changeset = TopicModel.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated!")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:warning, "There was a problem with saving this topic.")
        |> render("edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    topic = Repo.get(TopicModel, topic_id)
    Repo.get!(TopicModel, topic_id)
    |> Repo.delete!

    conn
    |> put_flash(:info, "Topic \"#{topic.title}\" was successfuly deleted!")
    |> redirect(to: topic_path(conn, :index))
  end
end
