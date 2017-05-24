//
//  ChangePasswordViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 5/24/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UIView+RNActivityView.h"
#import "UIViewController+KeyboardAnimation.h"
@interface ChangePasswordViewController ()
{
 NSDictionary * urlplist;
    NSUserDefaults *defaults;
    CALayer *borderBottom_topheder;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabBarBottomSpace;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    borderBottom_topheder=[[CALayer alloc]init];
    _Button_ChangePassword.enabled=NO;
    [_Button_ChangePassword setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _Button_ChangePassword.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [_Textfield_oldpassword becomeFirstResponder];
}
- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, _view_Topheader.frame.size.height-1, _view_Topheader.frame.size.width,1);
    [_view_Topheader.layer addSublayer:borderBottom_topheder];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self subscribeToKeyboard];
    
}
- (void)subscribeToKeyboard
{
    [self an_subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
        if (isShowing) {
            self.tabBarBottomSpace.constant = CGRectGetHeight(keyboardRect);
            
            
        } else
        {
            
            self.tabBarBottomSpace.constant = 0.0f;
        }
        [self.view layoutIfNeeded];
    } completion:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self an_unsubscribeKeyboard];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(IBAction)Button_BackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)Button_ChangePasswordAction:(id)sender
{
    [self ChangePasswordCommunication];
}





-(IBAction)TextfieldAction_ChangePassword:(id)sender
{
    UITextField *textfield = (UITextField *)sender;
    if (textfield.tag==1)
    {
    
    if ([_Textfield_oldpassword.text isEqualToString:@""] || [_Textfield_newpassword.text isEqualToString:@""] || [_Textfield_confirmpassword.text isEqualToString:@""])
    {
        _Button_ChangePassword.enabled=NO;
        
        [_Button_ChangePassword setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _Button_ChangePassword.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    }
    else
    {
     _Button_ChangePassword.enabled=YES;
        
        [_Button_ChangePassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Button_ChangePassword.backgroundColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
    }
    }
    if (textfield.tag==2)
    {
        
        if ([_Textfield_oldpassword.text isEqualToString:@""] || [_Textfield_newpassword.text isEqualToString:@""] || [_Textfield_confirmpassword.text isEqualToString:@""] || ![_Textfield_newpassword.text isEqualToString:_Textfield_confirmpassword.text])
        {
            _Button_ChangePassword.enabled=NO;
            [_Button_ChangePassword setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _Button_ChangePassword.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        }
        else
        {
            _Button_ChangePassword.enabled=YES;
            
            [_Button_ChangePassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _Button_ChangePassword.backgroundColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
        }
        
    }
    if (textfield.tag==3)
    {
        
        if ([_Textfield_oldpassword.text isEqualToString:@""] || [_Textfield_newpassword.text isEqualToString:@""] || [_Textfield_confirmpassword.text isEqualToString:@""] || ![_Textfield_newpassword.text isEqualToString:_Textfield_confirmpassword.text])
        {
            _Button_ChangePassword.enabled=NO;
            [_Button_ChangePassword setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _Button_ChangePassword.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        }
        else
        {
            _Button_ChangePassword.enabled=YES;
            
            [_Button_ChangePassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _Button_ChangePassword.backgroundColor=[UIColor colorWithRed:67/255.0 green:188/255.0 blue:255/255.0 alpha:1];
        }
    }
}
-(void)ChangePasswordCommunication
{
    
    
        [self.view endEditing:YES];
        [self.view showActivityViewWithLabel:@"Changing"];
        NSString *userid= @"userid";
         NSString *useridVal=[defaults valueForKey:@"userid"];
         NSString *oldpassword= @"oldpassword";
        
         NSString *newpassword= @"newpassword";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",userid,useridVal,oldpassword,_Textfield_oldpassword.text,newpassword,_Textfield_newpassword.text];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"changepassword"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
                    NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     
                                                     
                        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     
                    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     
                        if ([ResultString isEqualToString:@"changed"])
                                    {
                        [self.view hideActivityViewWithAfterDelay:0];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Password Changed" message:@"Your password has been changed successfully, and your new login details have also been sent to your registered email address. Thank-you" preferredStyle:UIAlertControllerStyleAlert];
                                                         
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
            style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                {
            [self.navigationController popViewControllerAnimated:YES];
                                   }];

                    [alertController addAction:actionOk];
                        [self presentViewController:alertController animated:YES completion:nil];
                       
                                        
                                                         
                                                     }
                                                     
                if ([ResultString isEqualToString:@"error"])
                 {
             [self.view hideActivityViewWithAfterDelay:0];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please enter your correct password and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"  style:UIAlertActionStyleDefault handler:nil];
                             [alertController addAction:actionOk];
                [self presentViewController:alertController animated:YES completion:nil];
                                                   
                                                         
                                                     }
                                
                                                     
              [self.view hideActivityViewWithAfterDelay:0];
                                                     
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     [self.view hideActivityViewWithAfterDelay:0];
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 [self.view hideActivityViewWithAfterDelay:0];
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                             
                                         }];
        [dataTask resume];
    }

@end
