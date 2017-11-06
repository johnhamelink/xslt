# Xslt

This library is a light wrapper around the
[xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html) tool which allows for XSLT
transformations of XML documents.

## Prerequesites

The library uses [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html) to process
the documents. It comes preinstalled on OSX, and can be installed simply on
debian-based linux distros with `apt-get install xsltproc`.

The library uses porcelain to communicate safely with xsltproc, so you should
install the [goon](https://github.com/alco/goon/releases) binary for the best
performance.

## Usage

```elixir
{:ok, transformed_xml} = Xslt.transform("/path/to/template.xml", "/path/to/xml_file.xml")
```

Using params:
```elixir
{:ok, transformed_xml} = Xslt.transform("/path/to/template.xml", "/path/to/xml_file.xml", "--stringparam var_name value")
```
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `xslt` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:xslt, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/xslt](https://hexdocs.pm/xslt).
