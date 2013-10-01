//
//  DetailViewController.h
//  InAppRage
//
//  Created by Brian McCaul on 10/1/13.
//  Copyright (c) 2013 Brian McCaul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
