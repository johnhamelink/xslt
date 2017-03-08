defmodule Xslt do
  @moduledoc """
  Documentation for Xslt.
  """

  alias Porcelain.Result

  def transform(template, xml) do
    Porcelain.shell("xsltproc #{template} #{xml}")
    |> handle_output
  end

  defp handle_output(%{status: 0, out: output}),
  do: {:ok, output}

  defp handle_output(%{status: 1}),
  do: {:error, "No argument"}

  defp handle_output(%{status: 2}),
  do: {:error, "Too many parameters"}

  defp handle_output(%{status: 3}),
  do: {:error, "Unknown option"}

  defp handle_output(%{status: 4}),
  do: {:error, "Failed to parse the stylesheet"}

  defp handle_output(%{status: 5}),
  do: {:error, "Error in the stylesheet"}

  defp handle_output(%{status: 6}),
  do: {:error, "Error in one of the documents"}

  defp handle_output(%{status: 7}),
  do: {:error, "Unsupported xsl:output method"}

  defp handle_output(%{status: 8}),
  do: {:error, "String parameter contains both quote and double-quotes"}

  defp handle_output(%{status: 9}),
  do: {:error, "Internal Processing error"}

  defp handle_output(%{status: 10}),
  do: {:error, "Processing was stopped by a terminating message"}

  defp handle_output(%{status: 11}),
  do: {:error, "Could not write the result to the output file"}

end
