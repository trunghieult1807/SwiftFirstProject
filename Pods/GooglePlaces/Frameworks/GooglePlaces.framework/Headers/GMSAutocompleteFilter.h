//
//  GMSAutocompleteFilter.h
//  Google Places SDK for iOS
//
//  Copyright 2016 Google Inc.
//
//  Usage of this SDK is subject to the Google Maps/Google Earth APIs Terms of
//  Service: https://developers.google.com/maps/terms
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * \defgroup PlacesAutocompleteTypeFilter GMSPlacesAutocompleteTypeFilter
 * @{
 */

/**
 * The type filters that may be applied to an autocomplete request to restrict results to different
 * types.
 */
typedef NS_ENUM(NSInteger, GMSPlacesAutocompleteTypeFilter) {
  /**
   * All results.
   */
  kGMSPlacesAutocompleteTypeFilterNoFilter,
  /**
   * Geeocoding results, as opposed to business results.
   */
  kGMSPlacesAutocompleteTypeFilterGeocode,
  /**
   * Geocoding results with a precise address.
   */
  kGMSPlacesAutocompleteTypeFilterAddress,
  /**
   * Business results.
   */
  kGMSPlacesAutocompleteTypeFilterEstablishment,
  /**
   * Results that match the following types:
   * "locality",
   * "sublocality"
   * "postal_code",
   * "country",
   * "administrative_area_level_1",
   * "administrative_area_level_2"
   */
  kGMSPlacesAutocompleteTypeFilterRegion,
  /**
   * Results that match the following types:
   * "locality",
   * "administrative_area_level_3"
   */
  kGMSPlacesAutocompleteTypeFilterCity,
};

/**@}*/

/**
 * This class represents a set of restrictions that may be applied to autocomplete requests. This
 * allows customization of autocomplete suggestions to only those places that are of interest.
 */
@interface GMSAutocompleteFilter : NSObject

/**
 * The type filter applied to an autocomplete request to restrict results to different types.
 * Default value is kGMSPlacesAutocompleteTypeFilterNoFilter.
 */
@property(nonatomic, assign) GMSPlacesAutocompleteTypeFilter type;

/**
 * The country to restrict results to. This should be a ISO 3166-1 Alpha-2 country code (case
 * insensitive). If nil, no country filtering will take place.
 */
@property(nonatomic, copy, nullable) NSString *country;

/**
 * The staight line distance origin location for measuring the straight line distance between the
 * origin location and autocomplete predictions.
 */
@property(nonatomic, nullable) CLLocation *origin;

@end

NS_ASSUME_NONNULL_END