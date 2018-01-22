defmodule Owl.Router do

  defmacro __using__(_opts) do
    quote do
      import Owl.Router

      def call(conn) do
        content_for(conn.req_path, conn)
      end
    end
  end

  defmacro get(path, controller, action) do
    quote do
       defp content_for(unquote(path), conn) do
         apply(unquote(controller), :call, [conn, unquote(action)])
      end
    end
  end

  defmacro get(path, controller, action, opts) do
    quote do
       defp content_for(unquote(path), conn) do
         apply(unquote(controller), :call, [conn, unquote(action), unquote(opts)])
      end
    end
  end

end