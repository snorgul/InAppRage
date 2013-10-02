//
//  MasterViewController.m
//  InAppRage
//
//  Created by Brian McCaul on 10/1/13.
//  Copyright (c) 2013 Brian McCaul. All rights reserved.
//
#import "MasterViewController.h"
#import "DetailViewController.h"

// Imports
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>

// Adds an instance variable to store the SKProducts returned from iTunes Connect
@interface MasterViewController () {
    NSArray *_products;
}
@end

@implementation MasterViewController

// Implements iOS 6 table view pull-to-refresh control
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"In App Rage";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [self reload];
    [self.refreshControl beginRefreshing];
    
}

// This will store the list of products in the instance variable, reload the table view to display them, and tells the refresh control to stop animating
- (void)reload {
    _products = nil;
    [self.tableView reloadData];
    [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = products;
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Standard table view stuff
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    SKProduct * product = (SKProduct *) _products[indexPath.row];
    cell.textLabel.text = product.localizedTitle;
    
    return cell;
}

@end