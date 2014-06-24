//
//  mainViewController.m
//  homework3
//
//  Created by Nathan Romero on 6/23/14.
//  Copyright (c) 2014 naromero. All rights reserved.
//

#import "mainViewController.h"

@interface mainViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *pageView;
@property (weak, nonatomic) IBOutlet UIImageView *headlineImage;
@property (weak, nonatomic) IBOutlet UIImageView *headlineImage2;
@property (weak, nonatomic) IBOutlet UIImageView *headlineImage3;


@property (assign,nonatomic) CGPoint offset;
@property (assign,nonatomic) CGPoint initialTouchPosition;
@property (assign,nonatomic) CGPoint finalTouchPosition;
@property (assign,nonatomic) CGPoint displacement;

@property (assign,nonatomic) float imageNo;

- (IBAction)onPan:(UIPanGestureRecognizer *)sender;

@end

@implementation mainViewController

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
    
    // Setup scrollview
    [self.scrollView setContentSize:CGSizeMake(1444, 253)];
    
    // Initialize image number
    self.imageNo = 0;
    
    // Timer to change background
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(bgChange) userInfo:nil repeats:YES];
    
}

- (void)bgChange
{
    // Loop through background images
    if (self.imageNo == 0) {
        
        [UIView animateWithDuration:.6 animations:^{
            self.headlineImage.layer.opacity = 1;
        }];
        self.imageNo++;
        
    } else if (self.imageNo == 1.0){
        
        self.headlineImage2.layer.opacity = 1;
        
        [UIView animateWithDuration:.6 animations:^{
            self.headlineImage.layer.opacity = 0;
        }];
        self.imageNo++;
        
    } else if (self.imageNo == 2.0){
        
        self.headlineImage3.layer.opacity = 1;
        
        [UIView animateWithDuration:.6 animations:^{
            self.headlineImage2.layer.opacity = 0;
        }];
        self.imageNo = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPan:(UIPanGestureRecognizer *)sender {
    
    // Store input information (position & velocity)
    CGPoint touchPosition = [sender locationInView:self.view];
    CGPoint touchVelocity = [sender velocityInView:self.view];

    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        //Store offset value
        self.offset = CGPointMake(touchPosition.x - self.pageView.center.x, touchPosition.y - self.pageView.center.y);
        
        // Initial position of touch
        self.initialTouchPosition = [sender locationInView:self.view];
        
        
    } else if(sender.state == UIGestureRecognizerStateChanged){
        
        if (self.pageView.center.y > 283 ) {
            
            // Assign center to offset touchPosition value
            self.pageView.center = CGPointMake(160, touchPosition.y - self.offset.y);
            
        } else {
            
            // Something here to give friction
            
        }
        
        
        
    } else if(sender.state == UIGestureRecognizerStateEnded){
                
        // Final position of touch
        self.finalTouchPosition = [sender locationInView:self.view];
        
        // Pan gesture displacement
        self.displacement = CGPointMake(self.finalTouchPosition.x - self.initialTouchPosition.x, self.finalTouchPosition.y - self.initialTouchPosition.y);
        
        // Displacement and velocity threshold values
        float touchThreshold = 100.0;
        float velocityThreshold = 800.0;
        
        if (self.displacement.y > touchThreshold || touchVelocity.y > velocityThreshold) {
            
            [UIView animateWithDuration:.3 animations:^{
                self.pageView.center = CGPointMake(160, 800);
            }];
            
        } else if(self.displacement.y < -touchThreshold || touchVelocity.y < -velocityThreshold){
            
            [UIView animateWithDuration:.3 animations:^{
                self.pageView.center = CGPointMake(160, 284);
            }];
            
        } else if(0 < self.displacement.y < touchThreshold){
            
            if (self.pageView.center.y > 568 ) {
                // Animate to top
                [UIView animateWithDuration:.3 animations:^{
                    self.pageView.center = CGPointMake(160, 800);
                }];
            } else if (self.pageView.center.y < 568) {
                
                // Animate to bottom
                [UIView animateWithDuration:.3 animations:^{
                    self.pageView.center = CGPointMake(160, 284);
                }];
            }
            
        } else if(0 > self.displacement.y > -touchThreshold){
            
            if (self.pageView.center.y > 568 ) {
                // Animate to top
                [UIView animateWithDuration:.3 animations:^{
                    self.pageView.center = CGPointMake(160, 284);
                }];
            } else if (self.pageView.center.y < 568) {
                
                // Animate to bottom
                [UIView animateWithDuration:.3 animations:^{
                    self.pageView.center = CGPointMake(160, 800);
                }];
            }
            
        }
        
    }
}
@end
