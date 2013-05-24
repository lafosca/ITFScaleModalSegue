//
//  ModalViewController.m
//  ITFScaleModalSegue
//
//  Created by Arol Viñolas on 24/05/13.
//  Copyright (c) 2013 lafosca. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setupNavbar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavbar{
    [[[self navigationController] navigationBar] configureFlatNavigationBarWithColor:[UIColor greenSeaColor]];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{UITextAttributeFont:[UIFont flatFontOfSize:20.f]}];
    
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor turquoiseColor]
                                  highlightedColor:[UIColor greenSeaColor]
                                      cornerRadius:3];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
