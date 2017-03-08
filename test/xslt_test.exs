defmodule XsltTest do
  use ExUnit.Case
  doctest Xslt

  test "Happy path" do
    xml = Path.expand("./test/fixtures/product/mws_doc_example.xml")
    template = Path.expand("./test/fixtures/product/xslt_template.xml")
    assert {:ok, _xml} = Xslt.transform(template, xml)
  end

  test "Unhappy path" do
    xml = Path.expand("./test/fixtures/product/doesntexist.xml")
    template = Path.expand("./test/fixtures/product/xslt_template.xml")
    assert {:error, "Error in one of the documents"} = Xslt.transform(template, xml)

    xml = Path.expand("./test/fixtures/product/mws_doc_example.xml")
    template = Path.expand("./test/fixtures/product/doesntexist.xml")
    assert {:error, "Failed to parse the stylesheet"} = Xslt.transform(template, xml)
  end
end
