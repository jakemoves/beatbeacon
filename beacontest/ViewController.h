//
//  ViewController.h
//  beacontest
//
//  Created by Jacob Niedzwiecki on 2015-01-12.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController <CBPeripheralManagerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) NSUUID *regionUUID;
@property (strong, nonatomic) NSString *regionIdentifier;

// TRANSMITTING
@property (strong, nonatomic) CLBeaconRegion *transmitBeaconRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

// RANGING
@property (strong, nonatomic) CLBeaconRegion *rangingBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;

// UI
- (IBAction)startTransmitting:(id)sender;
- (IBAction)startRanging:(id)sender;

@end

