defmodule XsltTest do
  use ExUnit.Case
  doctest Xslt

  test "Happy path" do
    xml = Path.expand("./test/fixtures/product/mws_doc_example.xml")
    template = Path.expand("./test/fixtures/product/xslt_template.xml")
    assert {:ok, _xml} = Xslt.transform(template, xml)
  end
  test "Happy path using params" do
    xml = Path.expand("./test/fixtures/product/mws_doc_example.xml")
    template = Path.expand("./test/fixtures/product/xslt_template.xml")
    assert {:ok, _xml} = Xslt.transform(template, xml, "--stringparam param value")
  end

  test "Unhappy path" do
    xml = Path.expand("./test/fixtures/product/doesntexist.xml")
    template = Path.expand("./test/fixtures/product/xslt_template.xml")
    assert {:error, _} = Xslt.transform(template, xml)

    xml = Path.expand("./test/fixtures/product/mws_doc_example.xml")
    template = Path.expand("./test/fixtures/product/doesntexist.xml")
    assert {:error, _} = Xslt.transform(template, xml)
  end
  test "Guards should return xml processed" do
    xml =  Path.expand("./test/fixtures/product/mws_doc_example.xml")
    template = Path.expand("./test/fixtures/product/xslt_template.xml")
    assert {:ok, _xml} = Xslt.transform(template, xml, nil)
    assert {:ok, _xml} = Xslt.transform(template, xml, :anything)
    assert {:ok, _xml} = Xslt.transform(template, xml, [])
  end
  test "Guards should return same xmls" do
    xml =  Path.expand("./test/fixtures/product/mws_doc_example.xml")
    {:ok, convert} = Xslt.transform(:anything, xml, "--stringparam param value")
    {:ok, fixture} = File.read(xml)
    assert fixture == convert
  end
  test "Guards should return a non enoent error" do
    xml =  Path.expand("./test/fixtures/product/doesntexist.xml")
    assert {:error, :enoent} = Xslt.transform(:anything, xml, "--stringparam param value")
  end
  test "Guards should return a bad_arguments error" do
    assert {:error, :bad_arguments} = Xslt.transform(:anything, :anything, "--stringparam param value")
  end
end
