defmodule Glue.Conn do

  defstruct req_path: "",
            resp_header: [{"content-type", "text/html"}],
            resp_body: "",
            status: 200


  def put_resp_body(conn, body) do
    %{conn | resp_body: body}
  end

  def put_status(conn, status_code) do
    %{conn | status: status_code}
  end

end