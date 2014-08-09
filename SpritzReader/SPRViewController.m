//
//  SPRViewController.m
//  SpritzReader
//
//  Created by Rodrigo Labanca on 8/9/14.
//  Copyright (c) 2014 Fancookie Inc. All rights reserved.
//

#import "SPRViewController.h"

#import <OSSpritzLabel.h>

@interface SPRViewController ()

@property (weak, nonatomic) IBOutlet OSSpritzLabel *spritz;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *wpmLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (nonatomic) BOOL paused;

@end

@implementation SPRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"mussumipsum"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    self.spritz.text = content;
    self.spritz.wordsPerMinute = 320;
    self.paused = YES;
    
    
}
- (IBAction)start:(id)sender {
    if (self.paused)
    {
        [self.spritz start];
        [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else
    {
        [self.spritz pause];
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    
    self.wpmLabel.hidden = self.paused;
    self.slider.hidden = self.paused;
    
    self.paused = !self.paused;
    
}

- (IBAction)wpmChange:(UISlider*)sender {
    self.spritz.wordsPerMinute = (NSInteger)sender.value;
    
    self.wpmLabel.text = [NSString stringWithFormat:@"%ld words per minute", (long)self.spritz.wordsPerMinute];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
