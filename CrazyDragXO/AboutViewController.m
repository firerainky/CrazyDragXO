//
//  AboutViewController.m
//  CrazyDragXO
//
//  Created by suchbalance on 7/17/16.
//  Copyright © 2016 suchbalance. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end


@implementation AboutViewController

@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"CrazyDrag" ofType:@"html"];
//    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
//    NSURL *baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
//    [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseUrl];
    
    NSURL *url = [NSURL URLWithString:@"http://apple.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
