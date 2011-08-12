Zip Code Zone
-------------

This extension provides Zones based on ZIP code ranges to the Spree e-Commerce
framework.

Eric Pierce (https://github.com/wapcaplet) originally wrote it for Spree 0.10.2.
Laurence A. Lee (https://github.com/rubyjedi) updated it for Spree 0.40.0 and Rails 3.


Installation
------------

To install, add this gem to your Gemfile and install the gem as usual with bundler.

    $ bundle install

If using Rails 3.0, run the extension's install rake task to copy over the database migration
and updated JavaScript file. This will change with Rails 3.1.

    $ rake spree_zip_code_zone:install

Then migrate your database to add the necessary tables:

    rake db:migrate


Usage
-----

ZIP code ranges can be edited from the Administration / Configuration interface; then a Zone
may be defined with one or more ZIP code ranges as members.

Once you've defined your zones, you can configure them for taxation or shipping like you
would with a state- or country-based zone.


Architecture
------------

This extension creates one new model, `ZipCodeRange`, which stores a starting
and ending ZIP code. The design of this model is based on the `State` model,
with slight changes to the comparison and `to_s` methods.

There is an `Admin::ZipCodeRangesController` that thinly wraps the administrative
views for creating, updating, and/or deleting ZIP code ranges.

The `zip_code_zone_extension.rb` contains overrides to the `Zone` and
`Admin::ZonesController` classes in order to support the `ZipCodeRange` model
as a zoneable type. Two `admin/zones` view partials are also overridden, as is the
`public/javascripts/zone.js` script responsible for showing and hiding the zonable
fields.

