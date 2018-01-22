defmodule Owl.Controller do

  defmacro __using__(_args) do
    quote do
      def call(conn, action) do
        apply(__MODULE__,  action, [conn, "Controller Here"])
      end

      def call(conn, action, params) do
        apply(__MODULE__,  action, [conn, params])
      end

      defoverridable [call: 2, call: 3]

      def render(conn, template, assigns) do
        view_name = __MODULE__
                    |> Atom.to_string
                    |> String.replace("Controller", "View")

        view_module = Module.concat(Elixir, view_name)
        body = view_module.render(template, assigns)
        Glue.Conn.put_resp_body(conn, body)
      end

      def render(conn, template) do
        render(conn, template, Enum.to_list(conn.assigns))
      end

    end
  end

end