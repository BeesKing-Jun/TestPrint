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
//    printer.transactionPrint(.PTR_S_RECEIPT, control: .PTR_TP_TRANSACTION)
//    _ = popUpError(errorCode: printer.setBitmap(1, station: .PTR_S_RECEIPT, fileName: imagePath!.absoluteString, width: 300, alignment: .PTR_BM_CENTER))
//    _ = popUpError(errorCode: printer.printNormal(.PTR_S_RECEIPT, data:"\u{001b}|1B"))
//    printer.transactionPrint(.PTR_S_RECEIPT, control: .PTR_TP_NORMAL)
//    [printer transactionPrint:PTR_S_RECEIPT Control:PTR_TP_TRANSACTION];
    
//    [printer setBitmap:1 Station:PTR_S_RECEIPT Bitmap:[UIImage imageNamed:@"test22"] Width:500 Alignment:PTR_BM_CENTER];
//    [printer transactionPrint:PTR_S_RECEIPT Control:PTR_TP_NORMAL];
    [printer printBitmap:PTR_S_RECEIPT Bitmap:[UIImage imageNamed:@"test22"] Width:500 Alignment:PTR_BM_CENTER];
    [printer cutPaper:100];
    [printer clearOutput];
    [printer setDeviceEnabled:NO];
    [printer releaseDevice];
    [printer close];
    count++;
    if (count <=2) {
        [self performSelector:@selector(testPrint) withObject:nil afterDelay:3];
//        [self performSelector:@selector(testPrint)];
    }
}

//- (NSString *)transformString:(NSString *)string {
//    NSString *tempStr1 =
//    [string stringByReplacingOccurrencesOfString:@"\\u"
//                                                 withString:@"\\U"];
//    NSString *tempStr2 =
//    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    NSString *tempStr3 =
//    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
//    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
//    return str;
//}

@end
