//
//  ViewController.m
//  CrazyDragXO
//
//  Created by suchbalance on 7/17/16.
//  Copyright © 2016 suchbalance. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () {
    int currentValue;
    int targetValue;
    int score;
    int round;
}

@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation ViewController

@synthesize slider;
@synthesize targetLabel;
@synthesize scoreLabel;
@synthesize roundLabel;

@synthesize audioPlayer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set slider image
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    
    [self playBackgroundMusic];
    
    [self startNewRound];
    [self updateLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startNewGame {
    score = 0;
    round = 0;
    [self startNewRound];
}

- (void)startNewRound {
    targetValue = 1 + arc4random() % 100;
    currentValue = 50;
    self.slider.value = currentValue / 100.0;
    round += 1;
}

- (void)updateLabels {
    self.targetLabel.text = [NSString stringWithFormat:@"%d", targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", round];
}

- (void)playBackgroundMusic {
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"no" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    
    if (audioPlayer == nil) {
        NSString *errorInfo = [NSString stringWithString:[error description]];
        NSLog(@"%@", errorInfo);
    } else {
        [audioPlayer play];
    }
}

- (IBAction)showAlert:(id)sender {
    int diff = abs(targetValue - currentValue);
    int points = 100 - diff;
    
    NSString *title;
    if (diff == 0) {
        title = @"Perfect";
        points += 100;
    } else if (diff < 5) {
        title = @"Great";
        points += 50;
    } else if (diff < 10) {
        title = @"Nice";
    } else {
        title = @"Not bad";
    }
    
    score += points;
    
    NSString *message = [NSString stringWithFormat:@"Slider current value is: %d, the targeted value is: %d, and your points is: %d", currentValue, targetValue, points];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self startNewRound];
        [self updateLabels];
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:^{}];
}

- (IBAction)sliderMoved:(UISlider *)sender {
    currentValue = (int)lroundf(sender.value * 100);
}

- (IBAction)startOver:(id)sender {
    // Add transition animation;
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

- (IBAction)showInfo:(id)sender {
    AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
