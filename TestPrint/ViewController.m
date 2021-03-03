//
//  ViewController.m
//  TestPrint
//
//  Created by Bees, Wang on 2021/1/29.
//

#import "ViewController.h"
#import "TECPOSPrinter.h"
#import "TRSTP1XPrinter.h"
#import "TRSTP2XPrinter.h"

@interface ViewController ()
{
    NSInteger count;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [TECPOSDevice setLogLevel:0x3F];
    [TECPOSDevice setLogFilePath:nil];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)buttonAction:(UIButton *)button
{
    count = 0;
    [self testPrint];
}

- (void)testPrint
{
    TRSTP2XPrinter *printer = [[TRSTP2XPrinter alloc] init];
    [printer open:@"LAN;192.168.1.157;9100;3000"];
    NSInteger code2 = [printer claimDevice:50000];
    NSInteger code3 = [printer setDeviceEnabled:YES];
    if (code2 != 0 || code3 != 0) {
        return;
    }
    [printer printBitmap:PTR_S_RECEIPT Bitmap:[UIImage imageNamed:@"test22"] Width:500 Alignment:PTR_BM_CENTER];
    [printer cutPaper:100];
    [printer clearOutput];
    [printer setDeviceEnabled:NO];
    [printer releaseDevice];
    [printer close];
    count++;
    if (count <=2) {
        //work for poor network.
        [self performSelector:@selector(testPrint) withObject:nil afterDelay:3];
        // not work for poor network.
//        [self performSelector:@selector(testPrint)];
    }
}


@end
