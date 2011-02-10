require 'spree_core'
require 'spree_zip_code_zone_hooks'

module SpreeBlankSkeleton
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      # This is mostly copied from the Spree 0.10.2 Zone methods,
      # with added support for ZipCodeRange zone members
      Zone.class_eval do
        def kind
          member = self.members.last
          case member && member.zoneable_type
          when "State"        then "state"
          when "Zone"         then "zone"
          when "ZipCodeRange" then "zip_code_range"
          else
            "country"
          end
        end
  
        # Check for whether an address.zipcode is
        # between the start/end of a ZipCodeRange
        def include?(address)
          return false unless address
  
          members.any? do |zone_member|
            case zone_member.zoneable_type
            when "Zone"
              zone_member.zoneable.include?(address)
            when "Country"
              zone_member.zoneable == address.country
            when "State"
              zone_member.zoneable == address.state
            when "ZipCodeRange"
              address.zipcode and address.zipcode.between?(
                zone_member.zoneable.start_zip,
                zone_member.zoneable.end_zip)
            else
              false
            end
          end
        end
      end # Zone
  
      Admin::ZonesController.class_eval do
        def load_data
          @countries = Country.all.sort
          @states = State.all.sort
          @zip_code_ranges = ZipCodeRange.all.sort
          @zones = Zone.all.sort
        end  
      end # Admin::ZonesController

    end

    config.to_prepare &method(:activate).to_proc
  end
end