//
//  ViewController.m
//  beacontest
//
//  Created by Jacob Niedzwiecki on 2015-01-12.
//  Copyright (c) 2015 Jacob Niedzwiecki. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _regionUUID = [[NSUUID alloc] initWithUUIDString:@"33cab6cd-9fa4-4a14-b8dd-46a25aaded21"];
    _regionIdentifier = @"com.jakemoves.beacontest";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TRANSMITTING

- (IBAction)startTransmitting:(id)sender {
    
    // for transmitting
    NSLog(@"Starting transmitting");
    [self initBeacon];
    [self transmitBeacon];
}

- (void)initBeacon {
    _transmitBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:_regionUUID major:1 minor:1/*arc4random_uniform(100)*/ identifier:_regionIdentifier];
}

- (void)transmitBeacon {
    _beaconPeripheralData = [self.transmitBeaconRegion peripheralDataWithMeasuredPower:nil];
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options: nil];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if(peripheral.state == CBPeripheralManagerStatePoweredOn){
        NSLog(@"Beacon powered on");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff){
        NSLog(@"Beacon powered off");
        [self.peripheralManager stopAdvertising];
    }
}

#pragma mark RANGING

- (IBAction)startRanging:(id)sender {
    
    // for ranging / passive
    
    NSLog(@"Starting ranging");
    [self initRegion];
}

- (void)initRegion{
    NSLog(@"initRegion");
    
    _rangingBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:_regionUUID major:1 minor:1 identifier:_regionIdentifier];
    
    _rangingBeaconRegion.notifyOnEntry=YES;
    _rangingBeaconRegion.notifyOnExit=YES;
    _rangingBeaconRegion.notifyEntryStateOnDisplay=YES;
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    [_locationManager startMonitoringForRegion:_rangingBeaconRegion];

}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"didStartMonitoringForRegion");
    [_locationManager requestStateForRegion:_rangingBeaconRegion];
    
    //    [_locationManager startRangingBeaconsInRegion:_rangingBeaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    NSLog(@"didDetermineState");
    if (state == CLRegionStateInside)
    {
        //Start Ranging
        NSLog(@"...inside region");
        [manager startRangingBeaconsInRegion:_rangingBeaconRegion];
    }
    else
    {
        NSLog(@"...not inside region");
        
        //testing only
        [manager startRangingBeaconsInRegion:_rangingBeaconRegion];
        //Stop Ranging here
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [_locationManager startRangingBeaconsInRegion:_rangingBeaconRegion];
    NSLog(@"Entered region %@", region);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [self.locationManager stopRangingBeaconsInRegion:_rangingBeaconRegion];
    NSLog(@"Exited region %@", region);
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"Ranging beacons:");
    
    for(CLBeacon *beacon in beacons){
        if([region.identifier isEqualToString:_rangingBeaconRegion.identifier]){
            NSLog(@"Ranging beacons in target region:");
            NSLog(@"    proximity: %d", beacon.proximity);
            NSLog(@"    RSSI:      %ld", (long)beacon.rssi);
            NSLog(@"    accuracy:  %f", beacon.accuracy);
            NSLog(@"    major:     %@", beacon.major);
            NSLog(@"    minor:     %@", beacon.minor);
        }
    }
}

#pragma mark TESTING

@end
