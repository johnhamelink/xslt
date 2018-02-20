defmodule Xslt do
  @moduledoc """

  Xslt is a lightweight wrapper around xsltproc. If you need to transform
  XML using XSLT this is probably the easiest way to do it.

  Using Porcelain, this library calls the xsltproc binary with the pathnames to
  your XML files. It will then return the transformed XML in response.

  """

  alias Porcelain.Result

  @type result :: {:ok, String.t} | {:error, String.t}

  @spec transform(template :: String.t, xml :: String.t) :: result
  @doc """
  Transforms XML using an XSLT template.

  ## Example:

      iex> xml = Path.expand("./test/fixtures/product/simple_example.xml")
      ...> template = Path.expand("./test/fixtures/product/xslt_template.xml")
      ...> {:ok, html} = Xslt.transform(template, xml)
      ...> Regex.replace(~r/\\n/, html, "")
      "<html> <head><title>Book Review</title></head> <body>  <bookreview>   <title lorem=\\"ipsum\\">wewt</title>  </bookreview> </body></html>"
  """

  def transform(template, xml) when is_bitstring(template) and is_bitstring(xml) do
    Porcelain.shell("xsltproc '#{template}' '#{xml}'")
    |> handle_output
  end
  def transform(_, xml) when is_bitstring(xml), do: File.read(xml)
  def transform(_, _), do: {:error, :bad_arguments}

  def transform(template, xml, params)  when is_bitstring(template) and is_bitstring(xml) and is_bitstring(params) do
    Porcelain.shell("xsltproc #{params} '#{template}' '#{xml}'")
    |> handle_output
  end
  def transform(template, xml, _) when is_bitstring(template) and is_bitstring(xml), do: transform(template, xml)
  def transform(_, xml, _) when is_bitstring(xml), do: File.read(xml)
  def transform(_, _, _), do: {:error, :bad_arguments}

  @spec handle_output(result :: Result.t) :: result
  defp handle_output(%Result{status: 0, out: output}),
  do: {:ok, output}

  defp handle_output(%Result{status: 1}),
  do: {:error, "No argument"}

  defp handle_output(%Result{status: 2}),
  do: {:error, "Too many parameters"}

  defp handle_output(%Result{status: 3}),
  do: {:error, "Unknown option"}

  defp handle_output(%Result{status: 4}),
  do: {:error, "Failed to parse the stylesheet"}

  defp handle_output(%Result{status: 5}),
  do: {:error, "Error in the stylesheet"}

  defp handle_output(%Result{status: 6}),
  do: {:error, "Error in one of the documents"}

  defp handle_output(%Result{status: 7}),
  do: {:error, "Unsupported xsl:output method"}

  defp handle_output(%Result{status: 8}),
  do: {:error, "String parameter contains both quote and double-quotes"}

  defp handle_output(%Result{status: 9}),
  do: {:error, "Internal Processing error"}

  defp handle_output(%Result{status: 10}),
  do: {:error, "Processing was stopped by a terminating message"}

  defp handle_output(%Result{status: 11}),
  do: {:error, "Could not write the result to the output file"}

end
