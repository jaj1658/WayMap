//
//  UserDataTableViewController.m
//  WayMap
//
//  Created by Jean Jeon on 4/25/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

#import "UserDataTableViewController.h"
#import "PlacesInformationViewController.h"
#import "AppDelegate.h"

@interface UserDataTableViewController ()

@end

@implementation UserDataTableViewController{
    NSArray *animals;
}

@synthesize sectionTitle, favoritesHit, userAddedHit, selectedPlace, placeName, backBarButtonItem, userAddedPlaces, favoritePlaces, sectionName;

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
}

- (void) backButtonPressed: (UIBarButtonItem *)sender{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated{
    AppDelegate* myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    for (GooglePlace* useraddedLocation in myDelegate.MyUserAddedLocations){
        for (GooglePlace* favs in myDelegate.FavoritedPlaces){
            if ([useraddedLocation.placeID isEqualToString:favs.placeID]){
                useraddedLocation.Favorited = true;
            }
        }
        for (GooglePlace* checkedIn in myDelegate.CheckInLocations)
        {
            if ([useraddedLocation.placeID isEqualToString:checkedIn.placeID]){
                useraddedLocation.CheckedIn = true;
        }    }
        for (GooglePlace* ratedPlaces in myDelegate.RatedPlaces){
            if ([useraddedLocation.placeID isEqualToString:ratedPlaces.placeID]){
                useraddedLocation.Rated=true;
                useraddedLocation.Rating=ratedPlaces.Rating;
            }
        }
        useraddedLocation.UserAdded=true;
}
    for (GooglePlace*FavPlaces in myDelegate.FavoritedPlaces){
        FavPlaces.Favorited=true;
        for (GooglePlace* checkedIn in myDelegate.CheckInLocations)
        {
            if ([FavPlaces.placeID isEqualToString:checkedIn.placeID]){
                FavPlaces.CheckedIn = true;
            }    }
        for (GooglePlace* ratedPlaces in myDelegate.RatedPlaces){
            if ([FavPlaces.placeID isEqualToString:ratedPlaces.placeID]){
                FavPlaces.Rated=true;
                FavPlaces.Rating=ratedPlaces.Rating;
            }
        }
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(favoritesHit == true){
        if([favoritePlaces count] > 0){
            return [favoritePlaces count];
        }
    }
    else if (userAddedHit == true){
        if([userAddedPlaces count] > 0){
            return [userAddedPlaces count];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(userAddedHit == true){
        cell.textLabel.text = userAddedPlaces[indexPath.row];
    }
    
    else{
        cell.textLabel.text = favoritePlaces[indexPath.row];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(userAddedHit == true){
        sectionName = @"ADDED BY USER";
    }
    else{
        sectionName = @"FAVORITES";
    }
    
    return sectionName;
}


-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedPlace = [tableView cellForRowAtIndexPath:indexPath];
    placeName = selectedPlace.textLabel.text;
    return indexPath;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"placesInfoSegue"]){
        
        PlacesInformationViewController *PIVC;
        PIVC = [segue destinationViewController];
        
        [PIVC.rateLabel setHidden:YES];
        
        for(UIImageView *FullStar in PIVC.fullStarsArray){
            [FullStar setHidden:YES];
        }
        
        for(UIImageView *EmptyStar in PIVC.emptyStarsArray){
            [EmptyStar setHidden:YES];
        }
        
        for(UIButton *button in PIVC.buttonsArray){
            [button setUserInteractionEnabled:NO];
        }
        
        AppDelegate *userAddedOrFavesDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        if([sectionName isEqualToString:@"ADDED BY USER"]){
            NSMutableArray *tempUserAdded = userAddedOrFavesDelegate.MyUserAddedLocations;
            
            for(GooglePlace *userPlace in tempUserAdded){
                if([userPlace.name isEqualToString:placeName]){
                    PIVC.SelectedPlace = userPlace;
                }
            }
        }
        else{
            NSMutableArray *tempFaves = userAddedOrFavesDelegate.FavoritedPlaces;
            
            for(GooglePlace *userPlace in tempFaves){
                if([userPlace.name isEqualToString:placeName]){
                    PIVC.SelectedPlace = userPlace;
                }

        }
    }
}
}

@end
    
