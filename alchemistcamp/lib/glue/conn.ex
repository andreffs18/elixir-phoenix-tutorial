defmodule Glue.Conn do

  defstruct assigns: %{},
            req_path: "",
            resp_header: [{"content-type", "text/html"}],
            resp_body: "",
            status: 200


  def put_resp_body(conn, body) do
    %{conn | resp_body: body}
  end

  def put_status(conn, status_code) do
    %{conn | status: status_code}
  end

  def assign(conn, key, value) do
    %Glue.Conn{assigns: assigns} = conn
    %{conn | assigns: Map.put(assigns, key, value)}
  end

end