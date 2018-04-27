//
//  PlacesInformationViewController.h
//  WayMap
//
//  Created by carlos arellano and jean jeon on 4/18/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GooglePlace.h"
@import Mapbox;
@import MapKit;
@import GooglePlaces;
@import GooglePlacePicker;

@interface PlacesInformationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *IsCheckedIn;
@property (weak, nonatomic) IBOutlet UIButton *CheckInButton;

@property (strong)  GooglePlace*SelectedPlace;
@property (strong)  NSString*segueUsed;
@property (weak, nonatomic) IBOutlet UILabel *UserAddedTitle;
@property (strong)  NSString*sourceArrayName;
@property (strong) NSMutableArray*CheckedInLocations;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;
@property (weak, nonatomic) IBOutlet UILabel *favoritedLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeAddressLabel;

@end
