//
//  JQBeaconViewController.h
//  beacontest
//
//  Created by Jacob Niedzwiecki on 2015-01-19.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface JQBeaconViewController : UIViewController <CBPeripheralManagerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) NSUUID *regionUUID;
@property (strong, nonatomic) NSString *regionIdentifier;

// TRANSMITTING
@property (strong, nonatomic) CLBeaconRegion *transmitBeaconRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

// RANGING
@property (strong, nonatomic) CLBeaconRegion *rangingBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) int16_t currentRSSI;
@property (nonatomic) double currentDistance;

// UI
- (IBAction)startTransmitting:(id)sender;
- (IBAction)startRanging:(id)sender;
- (IBAction)recordRSSI:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UITextView *logRSSI;

@end
