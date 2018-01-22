defmodule Owl.View do

  defmacro __using__(opts) do
    path = Keyword.fetch!(opts, :path)

    quote do
      def render(name, assigns) do
        try do
          EEx.eval_file "#{unquote(path)}/#{name}.eex", assigns
        rescue
          e in CompileError ->
            details = Enum.reduce(
              Map.from_struct(e), "",
              fn {k, v}, acc ->
                acc <> "<strong>#{k}:</strong> #{v}<br>"
              end)
            "<h1>Template Compile Error:</h1><br>#{details}"
        end
      end
    end
  end
end