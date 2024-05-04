# DocSales

![](out.gif)

## Introduction

This is a demo application, the specifications can be found at the project's
[README.md](https://github.com/docsales/technical-challange/blob/main/README.md).

## Requirements

Those are mostly the main ones:

- Ruby
- Rails
- PostgreSQL
- TeX Live

A working install of Ruby and Rails is required to run the app (I've used the
latest versions of everything). TeX Live is used to generate the PDF.

## Installation

    $ bundle install

## Usage

There are two routes (as defined in the specification).

- GET    /api/v1/documents/list
- POST   /api/v1/documents

The routes will either respond with 200 or 400, depending on what is being sent to the server.

To make a POST request:

    $ xh post http://localhost:3000/api/v1/documents \
    description="test" \
    document_data='{"customer_name": "Joe", "contract_value": 1000}' \
    template="$(cat template.html)"

The API also understands the `remote:=true` parameter, in this mode the PDF
file will be stored remotely and the `pdf_url` field will be updated
accordingly. Note that uploads are set to expire after 24 hours and the server
is hard-coded to 0x0.st but more providers can be added later.

Please be mindful when using this parameter, note that 0x0.st is a free of
charge service and abusing it is discouraged.

Similarly, to make a GET request:

    $ xh http://localhost:3000/api/v1/documents/list

## Running tests

Tests can be run with `rake`.

## Notes

You might be wondering why TeX Live is used to produce the final PDF document
and not some gem.

I've found that most of the well-known gems to convert HTML into PDF use the
`wkhtmltopdf` utility, which has been discontinued.

TeX Live (LaTeX) is fully supported on my Linux distribution, produces the
highest quality documents I've ever seen and LaTeX offers a high degree of
control over the presentation.

On my system (Arch Linux) those packages were required to get `xelatex` to
work:

- texlive-basic 2024.2-1
- texlive-bin 2024.2-1
- texlive-fontsrecommended 2024.2-1
- texlive-latex 2024.2-1
- texlive-xetex 2024.2-1

On macOS, TeX Live can be installed from Homebrew, the instructions can be found
[here](https://formulae.brew.sh/formula/texlive).
