//
//  ViewController.m
//  ITFScaleModalSegue
//
//  Created by Arol Viñolas on 24/05/13.
//  Copyright (c) 2013 lafosca. All rights reserved.
//

#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

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
    [self setupButton];
    
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

- (void)setupButton{
    [self button].buttonColor = [UIColor turquoiseColor];
    [self button].shadowColor = [UIColor greenSeaColor];
    [self button].shadowHeight = 3.0f;
    [self button].cornerRadius = 6.0f;
    [self button].titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [[self button] setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [[self button] setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

@end
