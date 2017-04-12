//
//  ContributeDaetailPageViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 3/16/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ContributeDaetailPageViewController.h"
#import "UIImageView+WebCache.h"
#import "ContributeMoneyViewController.h"
#import "RaisedContributeViewController.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import "Base64.h"
#import "MHFacebookImageViewer.h"
#import "UIImageView+MHFacebookImageViewer.h"
#import "ProfilePageDetailsViewController.h"
#import "WatchVediosViewController.h"



#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH self.view.frame.size.width-138
#define CELL_CONTENT_MARGIN 0.0f
@interface ContributeDaetailPageViewController ()<NSURLSessionDelegate>
{
    UIView *sectionView,*transperentViewIndicator,*whiteView1;
    UIImageView *Image_Share;
    UIButton *Button_Contribute;
    CGRect textRect;
    NSUserDefaults *defaults;
    NSDictionary *urlplist;
    NSString * CheckFavInserted,*chattype;
    UIImage *chosenImage;
    CGFloat HeightText0;
    CGRect TextViewCord,BackTextViewCord;
    CGFloat lastScale;
    CGFloat hh,ww,xx,yy,th,tw,xt,yt,bty,btw,bth,btx,Bluesch,Bluescw,Bluescy,Bluescx,textBluex,textBluey,textBluew,textBlueh,hhone,wwone,xxone,yyone;
    NSURLSessionDataTask *dataTaskupload;
       NSString * flag1,*String_Comment,*encodedImage,*imageUserheight,*imageUserWidth,*ImageNSdata,*TagId_plist,*strCameraVedio,*mediatypeVal,*ImageNSdataThumb,*encodedImageThumb;
    NSMutableArray * Array_Comment1,*Array_Comment,*Array_RecodVid,*Array_showrecordvid;
    NSData *imageData;
    NSArray *previousArray;
    CALayer *upperBorder,*upperBorder1;
    NSData *imageDataThumb;
    UIButton * Button_close;
    UIActivityIndicatorView *indicatorAlert;
    UILabel * Label_confirm,*Label_confirm1;
    
    UIImageView * Imagepro;
    UIScrollView * scrollView;
    CGFloat Xpostion, Ypostion, Xwidth, Yheight, ScrollContentSize,Xpostion_label, Ypostion_label, Xwidth_label, Yheight_label;
    CGRect scrollFrame;
    
}
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabBarBottomSpace;
@end

static const CGFloat kButtonSpaceShowed = 90.0f;
static const CGFloat kButtonSpaceHided = 24.0f;
#define kBackgroundColorShowed [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f];
#define kBackgroundColorHided [UIColor colorWithRed:0.18f green:0.67f blue:0.84f alpha:1.0f];



@implementation ContributeDaetailPageViewController
@synthesize cell_TwoDetails,cell_OneImageVid,cell_ThreeComments,Raised_amount,Button_back,Image_TotalLikes,Button_TotalPoints,ProfileImgeData,AllArrayData,view_Topheader,cell_recordvid;
@synthesize TextViews,BackTextViews;
@synthesize textOne,ViewTextViewOne,Tableview_ContriBute;


- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
     previousArray  = [[NSArray alloc]init];
    upperBorder = [CALayer layer];
      upperBorder1 = [CALayer layer];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];

    CheckFavInserted=[[AllArrayData objectAtIndex:0]valueForKey:@"favourite"];
   CALayer * borderBottom_topheder = [CALayer layer];
    borderBottom_topheder.backgroundColor =[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1.0].CGColor;
    borderBottom_topheder.frame = CGRectMake(0, view_Topheader.frame.size.height-1, view_Topheader.frame.size.width,1);
    [view_Topheader.layer addSublayer:borderBottom_topheder];
     NSLog(@"AllArrayData=%@",AllArrayData);;
    Raised_amount.text=[NSString stringWithFormat:@"%@%@",@"Raised: $",[[AllArrayData objectAtIndex:0] valueForKey:@"backamount"]];
    
      [Button_TotalPoints setTitle:[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0] valueForKey:@"backers"]] forState:UIControlStateNormal];
    
    Image_TotalLikes.userInteractionEnabled=YES;
    UITapGestureRecognizer * Image_TotalLikes_Tapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Image_TotalLikes_Action:)];
    [Image_TotalLikes addGestureRecognizer:Image_TotalLikes_Tapped];
    

    
    
    NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.height);
    NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.width);
    NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.origin.y);
    
    
    textOne.clipsToBounds=YES;
    textOne.layer.cornerRadius=7.0f;
    
    ViewTextViewOne.clipsToBounds=YES;
    ViewTextViewOne.layer.cornerRadius=9.0f;
    
    
     flag1=@"yes";
    
    
    hh=textOne.frame.size.height;
    ww=textOne.frame.size.width;
    xx=textOne.frame.origin.x;
    yy=textOne.frame.origin.y;
    
    
    
    if ([[UIScreen mainScreen]bounds].size.width==320 && [[UIScreen mainScreen]bounds].size.height==568)
    {
        
        ww=194.0;
        
    }
    else if ([[UIScreen mainScreen]bounds].size.width==375 && [[UIScreen mainScreen]bounds].size.height==667)
    {
        
        ww=249.0;
    }
    
    else  if ([[UIScreen mainScreen]bounds].size.width==414 && [[UIScreen mainScreen]bounds].size.height==736)
    {
        
        ww=288.0;
        
        
    }
    
    
    
    th=Tableview_ContriBute.frame.size.height;
    tw=Tableview_ContriBute.frame.size.width;
    xt=Tableview_ContriBute.frame.origin.x;
    yt=Tableview_ContriBute.frame.origin.y;
    
    bth=_BlackViewOne.frame.size.height;
    btw=_BlackViewOne.frame.size.width;
    btx=_BlackViewOne.frame.origin.x;
    bty=_BlackViewOne.frame.origin.y;
    
    Bluesch=_BlackViewOne.frame.size.height;
    Bluescw=_BlackViewOne.frame.size.width;
    Bluescx=_BlackViewOne.frame.origin.x;
    Bluescy=_BlackViewOne.frame.origin.y;
    
    
    
    
    //    CGRect previousRect = CGRectZero;
    self.BlackViewOne.frame = CGRectMake(0, 55, btw,87);
    self.textOne.frame = CGRectMake(xx, yy,ww,36);
    ViewTextViewOne.frame = CGRectMake(xx, yy, ww,36);
    
    
    
    //  Table_Friend_chat.frame = CGRectMake(0,-1, tw, th);
    //     Table_Friend_chat.frame = CGRectMake(0,yt, tw, th-10);
    // Table_Friend_chat.backgroundColor=[UIColor greenColor];
    
    
    
    
    
    
    //   [self.view addSubview:self.ewenTextView];
    //     _ewenTextView.backgroundColor = [UIColor clearColor];
    
    
    
    [TextViews becomeFirstResponder];
    
    TextViewCord=TextViews.frame;
    BackTextViewCord=BackTextViews.frame;
    HeightText0=TextViews.frame.size.height;
    TextViews.layer.cornerRadius=8.0f;
    self.sendButton.userInteractionEnabled = NO;
    self.sendButton.hidden=NO;
    self.sendButton.enabled=NO;
    self.placeholderLabel.hidden=NO;
    [self.sendButton setBackgroundColor:[UIColor colorWithRed:180/255.0 green:186/255.0 blue:190/255.0 alpha:1]];
    self.sendButton.layer.cornerRadius=self.sendButton.frame.size.height/2;
    self.sendButton.frame=CGRectMake((self.view.frame.size.width-self.sendButton.frame.size.width)-4, self.sendButton.frame.origin.y,self.sendButton.frame.size.width, self.sendButton.frame.size.height);
    
    self.ImageGalButton.userInteractionEnabled = YES;
    _ImageGalButton.hidden=NO;
    _ImageGalButton.enabled=YES;
    [self.ImageGalButton setBackgroundColor:[UIColor clearColor]];
    
    
    NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSLog(@"%@",NSHomeDirectory());
    
    NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];
    
    NSString * bundlePath = [[NSBundle mainBundle]pathForResource:@"ChatText" ofType:@"plist"];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:path])
    {
        NSLog(@"File alredy exists");
    }
    else
    {
        [[NSFileManager defaultManager]copyItemAtPath:bundlePath toPath:path error:nil];
    }
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    
    NSLog(@"dictionary setValue:=%@",dictionary );
    
        TagId_plist=[[AllArrayData valueForKey:@"challengeid"]objectAtIndex:0];
        
    
    
    
    BOOL contains = [[dictionary allKeys] containsObject:TagId_plist];
    if(contains==YES)
    {
        NSLog(@"YEsssssssssssss");
        Array_Comment1=[dictionary valueForKey:TagId_plist];
        [Tableview_ContriBute reloadData];
    }
    
//    Array_Comment1 = [[NSMutableArray alloc] initWithContentsOfFile:path];
//    NSLog(@"dictionary setValue:=%@",Array_Comment1 );
//
//    
//      TagId_plist=[defaults valueForKey:@"userid"];
//        //TagId_plist=[[AllArrayData valueForKey:@"useridsender"]objectAtIndex:0];
//      
//    
//           if(Array_Comment1.count>=1)
//        {
//          [Tableview_ContriBute reloadData];
//          
////         [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count-1 inSection:2] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//            
//        }
//        NSLog(@"data plist path array==%@",Array_Comment1);
    

    
    
    
    strCameraVedio=@"";
    
    
    
    transperentViewIndicator=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transperentViewIndicator.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
    whiteView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 150,150)];
    whiteView1.center=transperentViewIndicator.center;
    [whiteView1 setBackgroundColor:[UIColor blackColor]];
    whiteView1.layer.cornerRadius=9;
//   indicatorAlert = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicatorAlert.frame=CGRectMake(40, 40, 20, 20);
//    [indicatorAlert startAnimating];
//    [indicatorAlert setColor:[UIColor whiteColor]];
    
    Label_confirm1=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 150, 40)];
    
    [Label_confirm1 setFont:[UIFont systemFontOfSize:12]];
    Label_confirm1.text=@"0 %";
    Label_confirm1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:40.0];
    Label_confirm1.textColor=[UIColor whiteColor];
    Label_confirm1.textAlignment=NSTextAlignmentCenter;
    
    Label_confirm=[[UILabel alloc]initWithFrame:CGRectMake(0, 110, 150, 28)];
    
    [Label_confirm setFont:[UIFont systemFontOfSize:12]];
    Label_confirm.text=@"Uploading...";
    Label_confirm.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:20.0];
    Label_confirm.textColor=[UIColor whiteColor];
    Label_confirm.textAlignment=NSTextAlignmentCenter;
    
    Button_close=[[UIButton alloc]initWithFrame:CGRectMake(whiteView1.frame.size.width-23, -4, 28,28)];
    Button_close.layer.cornerRadius=Button_close.frame.size.height/2;
    
    Button_close.backgroundColor=[UIColor whiteColor];
    [Button_close setTitle:@"X" forState:UIControlStateNormal];
     [Button_close setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    Button_close.titleLabel.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:14.0];
    [Button_close addTarget:self action:@selector(UploadinView_Close:) forControlEvents:UIControlEventTouchUpInside];
      [whiteView1 addSubview:Button_close];
    [whiteView1 addSubview:Label_confirm];
    [whiteView1 addSubview:Label_confirm1];
    
    [transperentViewIndicator addSubview:whiteView1];
    
    [self.view addSubview:transperentViewIndicator];
    
    transperentViewIndicator.hidden=YES;
    
    
    
    
    
    
    
    
    
    
    Xpostion=12;
    Ypostion=0;
    Xwidth=60;
    Yheight=60;
    ScrollContentSize=0;
    Xpostion_label=12;
    Ypostion_label=67;
    Xwidth_label=60;
    Yheight_label=20;
    
    
    
    
    
    
    [self chatCommunication];
    [self Communication_showrecordVid];
    
    
    
    
    
    
    
    
}
-(void)UploadinView_Close:(UIButton *)sender
{
   Label_confirm1.text=@"0 %";
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"Cancel?" message:@"Are you sure you want to cancel your upload?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Resume"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                   
                                    [dataTaskupload resume];
                                    transperentViewIndicator.hidden=NO;
                                    
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                 
                                   [dataTaskupload cancel];
                                   transperentViewIndicator.hidden=YES;
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
   
}



-(void)Communication_showrecordVid
{
    [self.view endEditing:YES];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
        NSString *challengeid= @"challengeid";
        NSString *challengeidval =[[AllArrayData objectAtIndex:0] valueForKey:@"challengeid"];
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid,useridVal,challengeid,challengeidval];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"showvideos"];;
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
                                                     
                Array_showrecordvid=[[NSMutableArray alloc]init];
            SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_showrecordvid=[objSBJsonParser objectWithData:data];
                                                     
                                                     
                                                     
        NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                   
                                                     
 ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
    if(Array_showrecordvid.count !=0)
                {
                                                        
                    NSLog(@"showsVedio===%@",Array_showrecordvid);
                                                    
        [Tableview_ContriBute reloadData];
                                                         
                                                         
                    }
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                             
                                         }];
        [dataTask resume];
    }
    
    
}



//showvideos.php

-(void)chatCommunication
{
    [self.view endEditing:YES];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
        NSString *challengeid= @"challengeid";
        NSString *challengeidval =[[AllArrayData objectAtIndex:0] valueForKey:@"challengeid"];
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid,useridVal,challengeid,challengeidval];
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"chat"];;
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
                                                     
                                                     Array_Comment=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     Array_Comment=[objSBJsonParser objectWithData:data];
                                                     
                                                     
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
              
                                                     
       if(Array_Comment.count !=0)
      {
                                                         
          NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
          
          NSLog(@"%@",NSHomeDirectory());
          
          NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];
              
              NSMutableDictionary *savedValue1 = [[[NSMutableDictionary alloc] initWithContentsOfFile: path]mutableCopy];
              
              NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:path]mutableCopy];
              
              
              
              if(Array_Comment1.count==0 || savedValue1==nil)
              {
                  if (savedValue1==nil)
                  {
                      NSMutableDictionary *data;
                      
                      data = [[NSMutableDictionary alloc] init];
                      
                      [data setObject:Array_Comment forKey:TagId_plist];
                      [data writeToFile:path atomically:YES];
                  }
                  
              }
              
              
              NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
              
              NSLog(@"dictionary setValue:=%@",dictionary );
              
              if (Array_Comment.count!=0)
              {
                  Array_Comment1=Array_Comment;
                  [dictionary setObject:Array_Comment forKey:TagId_plist];
                  [dictionary writeToFile:path atomically:YES];
              }
              
              
              
              if (previousArray.count == Array_Comment.count)
              {
                  
              }
              else
              {
                  [Tableview_ContriBute reloadData];
              }
              
              
              
              
              
              
              
              if(Array_Comment.count>=1 && previousArray.count != Array_Comment.count )
              {
                  
                  
//                  [Table_Friend_chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                  
              }
              
              previousArray = Array_Comment;
              
          
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
//                                                         
//                                                         NSString * documnetPath1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//                                                         
//                                                         NSLog(@"%@",NSHomeDirectory());
//                                                         
//                                                         NSString * path = [documnetPath1 stringByAppendingPathComponent:@"ChatText.plist"];
//                                                         
//                                                         
//                                                        
//                                                             
//                                                       
//                                                 
//                                                                     [Array_Comment writeToFile:path atomically:YES];
//                                                                 
//                                                         
//                                                             
//                                                             if (previousArray.count == Array_Comment.count)
//                                    {
//                                                                 
//                                        }
//       else
//                                                             {
//        [Tableview_ContriBute reloadData];
//                                                             }
//       if(Array_Comment.count>=1 && previousArray.count != Array_Comment.count )
//                                                             {
//                                                                 
////          [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment.count-1 inSection:2] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//                                                                 
//                                                        }
//                                                             
//                                                             previousArray = Array_Comment;
//                                                             
//                                                             
                                                         
                                                         }
  
                                                         
                                                    
                                                     
                                                     
                                                     
                                                     
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                             
                                         }];
        [dataTask resume];
    }
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    Xpostion=12;
    Ypostion=0;
    Xwidth=60;
    Yheight=60;
    ScrollContentSize=0;
    Xpostion_label=12;
    Ypostion_label=67;
    Xwidth_label=60;
    Yheight_label=20;
    
    [self subscribeToKeyboard];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
 
    [self an_unsubscribeKeyboard];
}


- (void)subscribeToKeyboard {
    [self an_subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
        if (isShowing) {
            
            self.tabBarBottomSpace.constant = CGRectGetHeight(keyboardRect);
            
            if(Array_Comment1.count>=1)
            {

                [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count-1 inSection:3] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//

            }
            
            
            
            
        } else {
            
            self.tabBarBottomSpace.constant = 0.0f;
            
        }
        [self.view layoutIfNeeded];
    } completion:nil];}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
-(void)Image_TotalLikes_Action:(UIGestureRecognizer *)reconizer
{
    [self ButtonTotalPoints_Action:nil];
}
-(IBAction)Send_Comments:(id)sender
{
    String_Comment=textOne.text;
    [self sendComment];
    textOne.text=nil;
    _ImageGalButton.enabled=YES;
    _placeholderLabel.hidden=NO;
    self.BlackViewOne.frame = CGRectMake(0, 55, btw,87);
    self.textOne.frame = CGRectMake(xx, yy, ww,36);
    ViewTextViewOne.frame = CGRectMake(xx, yy, ww,36);
    self.sendButton.enabled=NO;
    self.sendButton.backgroundColor=[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1];
//    Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-(TextViews.contentSize.height+220));
    
    Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-_BlackViewOne.frame.size.height+90);
    self.ImageGalButton.userInteractionEnabled = YES;  // uday
    
}


-(void)sendComment
{
    
    [self.view endEditing:YES];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
        NSString *challengeid= @"challengeid";
        NSString *challengeidval =[[AllArrayData objectAtIndex:0] valueForKey:@"challengeid"];
        
        NSString *messege= @"message";
        NSString *messegeval =textOne.text;
        
        NSString *chattypes= @"chattype";
        

        
        NSString *chatimage= @"chatimage";
        
        
        NSString *imageheights= @"imageheight";
        
        NSString *imagewidths= @"imagewidth";
       

        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",userid,useridVal,challengeid,challengeidval,messege,messegeval,chattypes,chattype,chatimage,encodedImage,imagewidths,imageUserWidth,imageheights,imageUserheight];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"addchat"];;
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
                                                     
                                                    Array_Comment=[[NSMutableArray alloc]init];
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     Array_Comment=[objSBJsonParser objectWithData:data];
                                                     
                                                     
                                                     
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                   
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     if ([ResultString isEqualToString:@"nullerror"])
                                                     {
                                                      
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not retrieve your Account Id. Please login and try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                     }
                                                     if ([ResultString isEqualToString:@"nouserid"])
                                                     {
                                                                                                                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or it has been de-activated by the administrator. Please contact us for further details." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                         
                                                         
                                                     }
                                                     if ([ResultString isEqualToString:@"inserterror"])
                                                     {
                                                     
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Error in sending message. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                                     
                                                     if ([ResultString isEqualToString:@"messagenull"])
                                                     {
                                                        
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your message text seems to be empty. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                                     
                                                     if ([ResultString isEqualToString:@"imagenull"])
                                                     {
                                                        
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"You seem to have not selected an image to send. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                                                     
                                                     if ([ResultString isEqualToString:@"imageerror"])
                                                     {
                                                         
                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Could not upload the image you have selected. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                            style:UIAlertActionStyleDefault
                                                                                                          handler:nil];
                                                         [alertController addAction:actionOk];
                                                         [self presentViewController:alertController animated:YES completion:nil];
                                                         
                                                     }
                if(Array_Comment.count !=0)
      {
                                                         
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ChatText.plist"];
        NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:path]mutableCopy];
     NSMutableDictionary *savedValue1 = [[[NSMutableDictionary alloc] initWithContentsOfFile: path]mutableCopy];
                                                         
            if(Array_Comment1.count==0 || savedValue1==nil)
                                        {
                    if (savedValue1==nil)
                {
        NSMutableDictionary *data;
        data = [[NSMutableDictionary alloc] init];
                                                                 
          [data setObject:Array_Comment forKey:TagId_plist];
                [data writeToFile:path atomically:YES];
                     }
            }
 NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
    NSLog(@"dictionary setValue:=%@",dictionary);
         if(Array_Comment.count !=0)
         {
        Array_Comment1=Array_Comment;
        [dictionary setObject:Array_Comment forKey:TagId_plist];
    [dictionary writeToFile:path atomically:YES];
                            }
[Tableview_ContriBute reloadData];
        if(Array_Comment.count>=1)
        {
 [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment.count-1 inSection:3] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                                                             
                                                         }
                                                         
                                                     }

//                                                     if(Array_Comment.count !=0)
//                                                     {
//                                                         
//                                                         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                                                         NSString *documentsDirectory = [paths objectAtIndex:0];
//                                                         NSLog(@"NSHomeDirectory=%@",NSHomeDirectory());
//                                                         
//                                                         
//                                                         
//                                                         NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ChatText.plist"];
//                                                         
//                                                         
//                                                         
//                                                         NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:path]mutableCopy];
//                                                         
//                                                         
//                                                         NSMutableDictionary *savedValue1 = [[[NSMutableDictionary alloc] initWithContentsOfFile: path]mutableCopy];
//                                                         
////if(Array_Comment.count !=0)
////   {
////                                                             
////        [Array_Comment writeToFile:path atomically:YES];
////            Array_Comment1=Array_Comment;
////        [Tableview_ContriBute reloadData];
////           [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment.count-1 inSection:2] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
////                                                             
////                                                         }
//                                                         
//                                                        
//                                                     }
                                                     
                                                     
                                                     
                                                     

                                                     
                                                     
                                                 }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                             
                                             
                                         }];
        [dataTask resume];
    }
    
}
    


-(IBAction)CameraButtonAct:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take from camera",@"Choose from gallery",nil];
    popup.tag = 3;
    [popup showInView:self.view];
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex== 0)
    {
        
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
        //  [self.navigationController pushViewController:picker animated:YES];
        // [self.navigationController presentModalViewController:picker animated:YES];
    }
    if (buttonIndex== 1)
    {
        
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
        
        
        
    }
}
- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
  

    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    cameraUI.videoQuality = UIImagePickerControllerQualityTypeMedium;
    
    cameraUI.showsCameraControls = YES;
//    cameraUI.videoMaximumDuration = 07.0f;
    
    cameraUI.allowsEditing = YES;
    
    cameraUI.delegate = delegate;
   // cameraUI.view.frame=CGRectMake(5, 5, 310, 280);
  //  [self.view addSubview:cameraUI.view];
    [controller presentModalViewController:cameraUI animated: YES];
        transperentViewIndicator.hidden=NO;
    return YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    
    if ([strCameraVedio isEqualToString:@"Record"])
    {
        
        NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
        
        
        _videoController.view.hidden=NO;
        
        
        
        self.videoURL = info[UIImagePickerControllerMediaURL];
        
        
        
        mediatypeVal=@"VIDEO";
        
   
        self.videoURL = info[UIImagePickerControllerMediaURL];
        
        imageData=[NSData dataWithContentsOfFile:self.videoURL];
        // ImageNSdata = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        ImageNSdata = [Base64 encode:imageData];
        
        
        encodedImage = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdata,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
        
        
        
        [picker dismissViewControllerAnimated:YES completion:NULL];
        
        self.videoController = [[MPMoviePlayerController alloc] init];
        
        [self.videoController setContentURL:self.videoURL];
        
        
        
        [self.videoController setScalingMode:MPMovieScalingModeAspectFill];
        _videoController.fullscreen=YES;
        _videoController.allowsAirPlay=NO;
        _videoController.shouldAutoplay=YES;
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self.videoURL options:nil];
        
        
        
        
        
        AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        generateImg.appliesPreferredTrackTransform = YES;
        NSError *error = NULL;
        CMTime time = CMTimeMake(1, 7);
        CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
        NSLog(@"error==%@, Refimage==%@", error, refImg);
        
        
        UIImage *FrameImage= [[UIImage alloc] initWithCGImage:refImg];
        
        
        
        
        
        
        imageDataThumb = UIImageJPEGRepresentation(FrameImage, 0.0);
        
        
        ImageNSdataThumb = [Base64 encode:imageDataThumb];
        
        
        encodedImageThumb = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdataThumb,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
        
        if (encodedImageThumb !=nil)
        {
             [self Communication_RecordVid];
        }
        
        [self dismissModalViewControllerAnimated:YES];
    }
    
    else
    {
    
    
    
    
    chattype=@"IMAGE";
    chosenImage = info[UIImagePickerControllerOriginalImage];
    
    UIImageView *attachmentImageNew = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width-120, self.view.frame.size.height-127)];
    attachmentImageNew.image = chosenImage;
    attachmentImageNew.backgroundColor = [UIColor redColor];
    attachmentImageNew.contentMode = UIViewContentModeScaleAspectFit;
    
    
    float widthRatio = attachmentImageNew.bounds.size.width / attachmentImageNew.image.size.width;
    float heightRatio = attachmentImageNew.bounds.size.height / attachmentImageNew.image.size.height;
    float scale = MIN(widthRatio, heightRatio);
    float imageWidth = scale * attachmentImageNew.image.size.width;
    float imageHeight = scale * attachmentImageNew.image.size.height;
    
    NSLog(@"Size of pic is %f",imageWidth);
    NSLog(@"Size of pic is %f",imageHeight);
    if (imageWidth>=254)
    {
        imageUserWidth=[NSString stringWithFormat:@"%f",254.0];
    }
    else
    {
        imageUserWidth=[NSString stringWithFormat:@"%f",imageWidth];
    }
    
    imageUserheight=[NSString stringWithFormat:@"%f",imageHeight];
    
    UIImage *image =  [self scaleImage:chosenImage  toSize:CGSizeMake([imageUserWidth floatValue]*2,[imageUserheight floatValue]*2)];
    
    
    imageData = UIImageJPEGRepresentation(image,0.5);
    
    // ImageNSdata = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    ImageNSdata = [Base64 encode:imageData];
    
    
    encodedImage = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)ImageNSdata,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
    if ([[defaults valueForKey:@"letsChat"] isEqualToString:@"yes"] || [[defaults valueForKey:@"letsChatAd"] isEqualToString:@"yes"])
    {
        [picker dismissViewControllerAnimated:YES completion:NULL];
    }
    else
    {
        [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
    }
    
    [self sendComment];
    }
}



-(void)Communication_RecordVid
{
    [self.view endEditing:YES];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
   
        
        NSString *challengeid= @"challengeid";
        NSString * chslengeidval=[[AllArrayData objectAtIndex:0]valueForKey:@"challengeid"];
        
        NSString *mediatype= @"mediatype";
        
        
        
        NSString *media= @"media";
        
        NSString *mediaimagethumb=@"mediathumbnail";
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",userid,useridVal,challengeid,chslengeidval,mediatype,mediatypeVal,media,encodedImage,mediaimagethumb,encodedImageThumb];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"recordvideo"];;
        url =[NSURL URLWithString:urlStrLivecount];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];//Web API Method
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
     dataTaskupload =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                         {
                                             if(data)
                                             {
                                                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                 NSInteger statusCode = httpResponse.statusCode;
                                                 if(statusCode == 200)
                                                 {
                                                     
        Array_RecodVid=[[NSMutableArray alloc]init];
        SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
        Array_RecodVid=[objSBJsonParser objectWithData:data];
                NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     //        Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
                                                     
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     
                                                     NSLog(@"Array_RecodVid %@",Array_RecodVid);
                                                     
                               
                                                     NSLog(@"array_CreateChallenges ResultString %@",ResultString);
        if ([ResultString isEqualToString:@"recorded"])
                    {
                        [self Communication_showrecordVid];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success" message:@"Congratulations on recording your challenge. Your video has been successfully uploaded!" preferredStyle:UIAlertControllerStyleAlert];
                                                         
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
    style:UIAlertActionStyleDefault
    handler:nil];
    [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
                                       transperentViewIndicator.hidden=YES;
                                                         
                                                     }
                if ([ResultString isEqualToString:@"nouserid"] )
                {
                                                         
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account seems to be missing or has been deactivated. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
                                                         
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
        style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
                    transperentViewIndicator.hidden=YES;
                                                         
                    }
                if ([ResultString isEqualToString:@"nomedia"])
                {
                                                         
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your video file seems to be missing. Please record and upload again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
            style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            transperentViewIndicator.hidden=YES;
                                                         
                    }
                                                     
                if ([ResultString isEqualToString:@"imageerror"])
                                                    {
                                                         
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"There was an error in uploading your video. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
                            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                            style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:actionOk];
                        [self presentViewController:alertController animated:YES completion:nil];
                            transperentViewIndicator.hidden=YES;
                                                         
                                                     }
                                                     
                    if ([ResultString isEqualToString:@"updateerror"])
                                {
                                                         
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"There was an error in updating our records. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
        style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            transperentViewIndicator.hidden=YES;
                                                         
                        }
                if ([ResultString isEqualToString:@"nullerror"])
                        {
                                                         
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account id or challenge id seems to be missing. Please try again." preferredStyle:UIAlertControllerStyleAlert];
                                                         
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
                    transperentViewIndicator.hidden=YES;
                                                         
                                                     }
                                         
                                                     
                    }
                                                 
                                                 else
                                                 {
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                  transperentViewIndicator.hidden=YES;
                                                 }
                                                 
                                                 
                                             }
                                             else if(error)
                                             {
                                                 
        NSLog(@"error login2.......%@",error.description);
                                                 
                    NSLog(@"error login2.......%@",error.localizedDescription);
                                                 NSString * str_errorDesc=[NSString stringWithFormat:@"%@",error.localizedDescription];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:str_errorDesc preferredStyle:UIAlertControllerStyleAlert];
                                                 
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
             style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
      
         transperentViewIndicator.hidden=YES;

         
                                                 
                    }
                                             
                                             
            }];
        [dataTaskupload resume];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    chattype=@"";
    transperentViewIndicator.hidden=YES;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(IBAction)ButtonTotalPoints_Action:(id)sender
{
    
    
RaisedContributeViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"RaisedContributeViewController"];
    set.Str_Channel_Id=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengeid"]];
    set.Str_Raised_Amount=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"backamount"]];
    [self.navigationController pushViewController:set animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
           return 1;
    }
    if (section==1)
    {
        return 1;
    }
    if ( section==2)
    {
            
    if (Array_showrecordvid.count==0)
    {
                return 0;
    }
        else
        {
          return 1;
        }

    }
    if (section==3)
    {
        return Array_Comment1.count;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellone=@"CellOne";
    static NSString *celltwo=@"CellTwo";
    static NSString *cellthree=@"CellComent";
      static NSString *cellIdR1=@"CellRV";
    
    switch (indexPath.section)
    {
            
        case 0:
        {
            cell_OneImageVid = (OneImageVedioTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellone forIndexPath:indexPath];
            
            
            
            
            if ([CheckFavInserted isEqualToString:@"TRUE"])
            {
                [cell_OneImageVid.Image_Favourite setImage:[UIImage imageNamed:@"challenge_favourite1.png"]];
            }
            else
            {
               [cell_OneImageVid.Image_Favourite setImage:[UIImage imageNamed:@"challenge_favourite.png"]];
            }
           
       
            
            UITapGestureRecognizer *FavouriteTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(FavouriteTapped_Action:)];
            [cell_OneImageVid.Image_Favourite addGestureRecognizer:FavouriteTapped];

            UITapGestureRecognizer *FlagTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(FlagTapped_Action:)];
            [cell_OneImageVid.Image_Flag addGestureRecognizer:FlagTapped];

            if ([[[AllArrayData objectAtIndex:0]valueForKey:@"mediatype"] isEqualToString:@"IMAGE"])
            {
                cell_OneImageVid.image_playButton.hidden=YES;
            }
            else
            {
             cell_OneImageVid.image_playButton.hidden=NO;
            }
            cell_OneImageVid.Image_Backround.image=ProfileImgeData.image;
            
            return cell_OneImageVid;
            
            
        }
            break;
        case 1:
            
        {
                            cell_TwoDetails = (TwoDetailsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:celltwo forIndexPath:indexPath];
            
            
            
            if (indexPath.row==0)
            {
                cell_TwoDetails.Label_CommentDesc.hidden=YES;
                cell_TwoDetails.label_CommentHeader.hidden=YES;
                cell_TwoDetails.image_ProfileComment.hidden=YES;
                
                cell_TwoDetails.Label_Dayleft.hidden=NO;
                cell_TwoDetails.label_Desc.hidden=NO;
                cell_TwoDetails.label_Mores.hidden=NO;
                cell_TwoDetails.image_SecProfile.hidden=NO;
                cell_TwoDetails.image_FristProfile.hidden=NO;
                cell_TwoDetails.ProgressBar_Total.hidden=NO;
                cell_TwoDetails.label_Moretxt.hidden=NO;
                cell_TwoDetails.label_ChallengesTxt.hidden=NO;
                
                
                NSURL *urlFirst=[NSURL URLWithString:[[AllArrayData objectAtIndex:0] valueForKey:@"usersprofilepic"]];
                
                NSURL *urlSec=[NSURL URLWithString:[[AllArrayData objectAtIndex:0] valueForKey:@"challengersprofilepic"]];
                
                [cell_TwoDetails.image_FristProfile sd_setImageWithURL:urlFirst placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                
                
                
                
                
                
                
                   [cell_TwoDetails.image_SecProfile sd_setImageWithURL:urlSec placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
                
                
        cell_TwoDetails.image_SecProfile.userInteractionEnabled=YES;
                
        UITapGestureRecognizer *image_SecProfileTapped =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image_SecProfile_ActionDetails:)];
        [cell_TwoDetails.image_SecProfile addGestureRecognizer:image_SecProfileTapped];
                
                
                
                if ([[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengerdetails1"]]isEqualToString:@""])
                {
                    cell_TwoDetails.label_Mores.hidden=YES;
                    cell_TwoDetails.label_Moretxt.hidden=YES;
                }
                else
                {
                cell_TwoDetails.label_Mores.text=[NSString stringWithFormat:@"%@%@",@"+",[[AllArrayData objectAtIndex:0]valueForKey:@"challengerdetails1"]];
                }
              
                 cell_TwoDetails.label_Desc.text=[[AllArrayData objectAtIndex:0]valueForKey:@"title"];
                
                
                NSString *text =[[AllArrayData objectAtIndex:0]valueForKey:@"title"];;
                
                
                CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
                
                CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
                
                CGFloat height = MAX(size.height, 30.0f);
                NSLog(@"Dynamic label height====%f",height);
                cell_TwoDetails.label_Desc.numberOfLines=0;
    cell_TwoDetails.label_Desc.lineBreakMode=UILineBreakModeWordWrap;
           
                
        NSInteger rHeight = size.height/FONT_SIZE;
                NSLog(@"No of lines: %ld",(long)rHeight);
                

            [cell_TwoDetails.label_Desc setFrame:CGRectMake(cell_TwoDetails.label_Desc.frame.origin.x,cell_TwoDetails.label_Desc.frame.origin.y, cell_TwoDetails.label_Desc.frame.size.width,size.height+70)];
                

                
                
                
                 cell_TwoDetails.Label_Dayleft.text=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"createtime1"]];
                
                NSString * tagreach=[[AllArrayData objectAtIndex:0]valueForKey:@"daysleft"];
                
                
                CGFloat progrssVal=1-([tagreach floatValue])/30.0;
                NSString *per= [ NSString stringWithFormat:@"%.3f",progrssVal];
                [cell_TwoDetails.ProgressBar_Total setProgress:[per floatValue]];

                
                CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 2.5f);
                cell_TwoDetails.ProgressBar_Total.transform = transform;
                cell_TwoDetails.ProgressBar_Total.clipsToBounds = YES;
                cell_TwoDetails.ProgressBar_Total.layer.cornerRadius = 2;
            }
            else if (indexPath.row==1)
            {
                cell_TwoDetails.Label_CommentDesc.hidden=YES;
                cell_TwoDetails.label_CommentHeader.hidden=NO;
                cell_TwoDetails.image_ProfileComment.hidden=YES;
                
                cell_TwoDetails.Label_Dayleft.hidden=YES;
                cell_TwoDetails.label_Desc.hidden=YES;
                cell_TwoDetails.label_Mores.hidden=YES;
                cell_TwoDetails.image_SecProfile.hidden=YES;
                cell_TwoDetails.image_FristProfile.hidden=YES;
                cell_TwoDetails.ProgressBar_Total.hidden=YES;
                cell_TwoDetails.label_Moretxt.hidden=YES;
                cell_TwoDetails.label_ChallengesTxt.hidden=YES;
                
                
                
                
                
                
            }
            else
                
            {
                cell_TwoDetails.Label_CommentDesc.hidden=NO;
                cell_TwoDetails.label_CommentHeader.hidden=YES;
                cell_TwoDetails.image_ProfileComment.hidden=NO;
                
                cell_TwoDetails.Label_Dayleft.hidden=YES;
                cell_TwoDetails.label_Desc.hidden=YES;
                cell_TwoDetails.label_Mores.hidden=YES;
                cell_TwoDetails.image_SecProfile.hidden=YES;
                cell_TwoDetails.image_FristProfile.hidden=YES;
                cell_TwoDetails.ProgressBar_Total.hidden=YES;
                cell_TwoDetails.label_Moretxt.hidden=YES;
                cell_TwoDetails.label_ChallengesTxt.hidden=YES;
                
               
                }
    
                
               
                
                
                return cell_TwoDetails;
                
            }
    
    
            break;
        case 2:
        {
            
            
            
            cell_recordvid = [[[NSBundle mainBundle]loadNibNamed:@"RecordedVidTableViewCell" owner:self options:nil] objectAtIndex:0];
            
            
            
            if (cell_recordvid == nil)
            {
                
                cell_recordvid = [[RecordedVidTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdR1];
                
                
            }
            
            if (Array_showrecordvid.count==0)
            {
                cell_recordvid.LAbel_Result.hidden=NO;
                cell_recordvid.myscrollView.hidden=YES;
            }
            else
            {
             cell_recordvid.LAbel_Result.hidden=YES;
                cell_recordvid.myscrollView.hidden=NO;
                
                
                for (int i=0; i<Array_showrecordvid.count; i++)
                {
                    
                     Imagepro = [[UIImageView alloc] initWithFrame:CGRectMake(Xpostion, Ypostion, Xwidth, Yheight)];
                    
                    
                    
                    Imagepro.userInteractionEnabled=YES;
                    
                    [Imagepro setTag:i];
                    
                    
                    UITapGestureRecognizer * ImageTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(ImageTapped_profile:)];
                    [Imagepro addGestureRecognizer:ImageTap];
                    
                    
                    Imagepro.clipsToBounds=YES;
                    Imagepro.layer.cornerRadius=9.0f;
                    
                    
                    [cell_recordvid.myscrollView addSubview:Imagepro];
                    
                    Imagepro.backgroundColor=[UIColor redColor];
                    //                name = "Er Sachin Mokashi";
                    //                profileimage = "https://graph.facebook.com/1280357812049167/picture?type=large";
                    //                recorddate = "2017-04-05 06:55:53";
                    //                "registration_status" = ACTIVE;
                    //                useridvideo = 20170307091520wFL3;
                    //                videourl = "http://www.care2dareapp.com/app/recordedmedia/R20170307091520wFL3C20170404122329IEXZ-thumbnail.jpg";
                    
                    
                    NSURL * url=[[Array_showrecordvid objectAtIndex:i]valueForKey:@"thumbnailurl"];
                    
                    
                    
                    [Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                    
                    
                    
                    
                    
                    Xpostion+=Xwidth+20;
                    
                    
                    ScrollContentSize+=Xwidth;
                    cell_recordvid.myscrollView.contentSize=CGSizeMake(Xpostion, 88);
                }
                Xpostion=12;
                Ypostion=0;
                Xwidth=60;
                Yheight=60;
                ScrollContentSize=0;
                Xpostion_label=12;
                Ypostion_label=67;
                Xwidth_label=60;
                Yheight_label=20;
                
            }
            
            
            //            if (Array_Challengers==0)
            //            {
            //                cell_one.Label_Noresult.hidden=NO;
            //            }
            //            else
            //            {
            //                cell_one.Label_Noresult.hidden=YES;
            //            }
            
            return cell_recordvid;
            
            
        }
            break;
        case 3:
            
        {
            
            UILabel *label = nil;
            UILabel *label1 = nil;
            
            UIImageView * desc_Imagepro=nil;
            UIImageView * Chat_ImageRight=nil;
            UIImageView * Chat_UserImage=nil;
            

            
            cell_ThreeComments = [Tableview_ContriBute dequeueReusableCellWithIdentifier:@"Cell"];
           
            
            if (cell_ThreeComments == nil)
            {
             
                
                cell_ThreeComments = [[CommentsTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellthree] ;
                
                label1 = [[UILabel alloc] initWithFrame:CGRectZero];
                [label1 setLineBreakMode:UILineBreakModeWordWrap];
                //        [label1 setMinimumFontSize:FONT_SIZE];
                [label1 setNumberOfLines:0];
                //        [label1 setFont:[UIFont systemFontOfSize:FONT_SIZE]];
                [label1 setTag:1];
                // [[label layer] setBorderWidth:2.0f];
                [label1 setBackgroundColor:[UIColor clearColor]];
                
                
                
                
                
                [[cell_ThreeComments contentView] addSubview:label1];
                
                label = [[UILabel alloc] initWithFrame:CGRectZero];
                [label setLineBreakMode:UILineBreakModeWordWrap];
                //        [label setMinimumFontSize:FONT_SIZE];
                [label setNumberOfLines:0];
                [label setFont:[UIFont fontWithName:@"Helvetica-Light" size:FONT_SIZE]];
                [label setTag:5];
                // [[label layer] setBorderWidth:2.0f];
                [label setBackgroundColor:[UIColor clearColor]];
                
                
                
                
                
                [[cell_ThreeComments contentView] addSubview:label];
                
                desc_Imagepro = [[UIImageView alloc] initWithFrame:CGRectZero];
                
                [desc_Imagepro setTag:4];
                
                [desc_Imagepro setBackgroundColor:[UIColor lightGrayColor]];
                
                [[cell_ThreeComments contentView] addSubview:desc_Imagepro];
                
                
                Chat_ImageRight = [[UIImageView alloc] initWithFrame:CGRectZero];
                
                [Chat_ImageRight setTag:4];
                
                [Chat_ImageRight setBackgroundColor:[UIColor lightGrayColor]];
                
                [[cell_ThreeComments contentView] addSubview:Chat_ImageRight];
                
                Chat_UserImage = [[UIImageView alloc] initWithFrame:CGRectZero];
                
                [Chat_UserImage setTag:5];
                
                [Chat_UserImage setBackgroundColor:[UIColor lightGrayColor]];
                
                [[cell_ThreeComments contentView] addSubview:Chat_UserImage];
                
                
                
            }
            
         
             cell_ThreeComments.selectionStyle=UITableViewCellSelectionStyleNone;
        
            
            if (!label)
                label = (UILabel*)[cell_ThreeComments viewWithTag:1];
            
            if (!label1)
                label1 = (UILabel*)[cell_ThreeComments viewWithTag:2];
            
            
            //                NSTextAlignmentLeft      = 0,
            //                NSTextAlignmentCenter    = 1,
            //                NSTextAlignmentRight     = 2,
            //                NSTextAlignmentJustified = 3,
            [label setBackgroundColor:[UIColor clearColor]];
            
            //    label.font=[UIFont fontWithName:@"Helvetica" size:16.0f];
            label.textColor=[UIColor blackColor];
            
            
            if ([[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"messagetype"] isEqualToString:@"TEXT"])
            {
                
                NSString *text =[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"message"];
                
                
                CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
                
                CGSize size = [text sizeWithFont:[UIFont fontWithName:@"Helvetica-Light" size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
                
                int lines = size.height/16;
                
                NSLog(@"lines count : %i \n\n",lines);
                
                
                
                [label setFont:[UIFont fontWithName:@"SanFranciscoDisplay" size:15.0f]];;
                
                NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
                style.alignment = NSTextAlignmentLeft;
                style.firstLineHeadIndent = 10.0f;
                style.headIndent = 10.0f;
                style.tailIndent = -10.0f;
                
                NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:@{ NSParagraphStyleAttributeName : style}];
                
                label.numberOfLines = 0;
                label.attributedText = attrText;
                
                   [label setText:text];
                
                label.clipsToBounds=YES;
                label.layer.cornerRadius=9.0f;
                label1.backgroundColor=[UIColor colorWithRed:13/255.0 green:146/255.0 blue:220/255.0 alpha:0.8];
                
               
                
                if ([[defaults valueForKey:@"userid"] isEqualToString:[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"useridsender"]])
                {
                    NSURL * url=[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"profileimage"];
                    [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                    
                    
                    label.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:0.7];
                    //        label.textColor=[UIColor colorWithRed:124/255.0 green:111/255.0 blue:164/255.0 alpha:0.7];
                    label.textColor=[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
                    if (size.width <=self.view.frame.size.width-132)
                    {
                        
                        //            [label1 setFrame:CGRectMake(50,0, size.width+34, MAX(size.height, 30.0f)+4)];
                        [label setFrame:CGRectMake(50,0, size.width+22, MAX(size.height, 30.0f)+8)];
                        
                        
                    }
                    
                    else
                    {
                        //            [label1 setFrame:CGRectMake(50,0, self.view.frame.size.width-132, MAX(size.height, 30.0f)+4)];
                        [label setFrame:CGRectMake(50,0, self.view.frame.size.width-140,MAX(size.height, 30.0f)+8)];
                        
                        
                    }
                    
                    Chat_ImageRight.backgroundColor=[UIColor clearColor];
                    [Chat_ImageRight setFrame:CGRectMake(label.frame.origin.x-14,label.frame.size.height-27, 16,16)];
                    [Chat_ImageRight setImage:[UIImage imageNamed:@"Chat_arrow_left.png"]];
                    
                    //chat_arrow_right.png
                    [desc_Imagepro setFrame:CGRectMake(8,label.frame.origin.y+(label.frame.size.height-32),32,32)];
                    desc_Imagepro.clipsToBounds=YES;
                    desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
                }
                else
                {
                    NSURL * url=[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"profileimage"];
                    [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                    
                    label.backgroundColor=[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:0.2];
                    
                    
                    label.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
                    
                    if (size.width <=self.view.frame.size.width-132)
                    {
                        
                        
                        [label setFrame:CGRectMake(self.view.frame.size.width-(size.width+83),0, size.width+22, MAX(size.height, 30.0f)+8)];
                    }
                    
                    else
                    {
                        
                        
                        
                        [label setFrame:CGRectMake(self.view.frame.size.width-(size.width+83),0, self.view.frame.size.width-140, MAX(size.height, 30.0f)+8)];
                        
                        
                        
                    }
                    Chat_ImageRight.backgroundColor=[UIColor clearColor];
                    [Chat_ImageRight setFrame:CGRectMake(label.frame.size.width+label.frame.origin.x-2,label1.frame.size.height-27, 16,16)];
                    
                    
                    [Chat_ImageRight setImage:[UIImage imageNamed:@"Chat_arrow_right.png"]];
                    
                    [desc_Imagepro setFrame:CGRectMake(self.view.frame.size.width-48,label.frame.origin.y+(label.frame.size.height-32),32,32)];
                    desc_Imagepro.clipsToBounds=YES;
                    desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
                }
                
                
                
                
            }
            
            else
            {
                
                
                CGFloat imgwidth=[[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"imagewidth"] floatValue];
                CGFloat imgheight=[[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"imageheight"] floatValue];
                
                //Chat_UserImage.backgroundColor=[UIColor clearColor];
                NSURL * url=[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"imageurl"];
                [Chat_UserImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                Chat_UserImage.clipsToBounds=YES;
                Chat_UserImage.layer.cornerRadius=9.0f;
                Chat_UserImage.contentMode=UIViewContentModeScaleAspectFit;
                
                
                
                
                
                
                
                if ([[defaults valueForKey:@"userid"] isEqualToString:[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"useridsender"]])
                {
                    
                    NSURL * url=[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"profileimage"];
                    [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                    
                    [Chat_UserImage setFrame:CGRectMake(52,4,imgwidth,imgheight)];
                    Chat_UserImage.clipsToBounds=YES;
                    Chat_UserImage.layer.cornerRadius=9.0f;
                    Chat_UserImage.contentMode=UIViewContentModeScaleAspectFit;
                    [self displayImage:Chat_UserImage withImage:Chat_UserImage.image];
                    
                    [desc_Imagepro setFrame:CGRectMake(8,Chat_UserImage.frame.origin.y+(Chat_UserImage.frame.size.height-32),32,32)];
                    desc_Imagepro.clipsToBounds=YES;
                    desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
                    
                }
                else
                {
                    
                    
                    NSURL * url=[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"profileimage"];
                    [desc_Imagepro sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"]options:SDWebImageRefreshCached];
                    
                    
                    [Chat_UserImage setFrame:CGRectMake((self.view.frame.size.width-64)-imgwidth,4,imgwidth,imgheight)];
                    Chat_UserImage.clipsToBounds=YES;
                    Chat_UserImage.layer.cornerRadius=9.0f;
                    Chat_UserImage.contentMode=UIViewContentModeScaleAspectFit;
                    
                    [self displayImage:Chat_UserImage withImage:Chat_UserImage.image];
                    
                    [desc_Imagepro setFrame:CGRectMake(self.view.frame.size.width-48,Chat_UserImage.frame.origin.y+(Chat_UserImage.frame.size.height-32),32,32)];
                    desc_Imagepro.clipsToBounds=YES;
                    desc_Imagepro.layer.cornerRadius=desc_Imagepro.frame.size.height/2;
                }
                
                
            }
            
            
            
            
            
            return cell_ThreeComments;
            
        }
            
            break;

        
    }
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        return 223;
    }
    if (indexPath.section==1)
    {
        NSString *text =[[AllArrayData objectAtIndex:0]valueForKey:@"title"];;
        
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat height = MAX(size.height, 30.0f);
        NSLog(@"Dynamic label height====%f",height);
       if(height <=30)
       {
        return 148+size.height+10;
       }
        else
        {
          return 148+size.height+40;
        }
        
    }
    if (indexPath.section==2)
    {
        if (Array_showrecordvid.count==0)
        {
            return 0;
        }
        else
        {
          return 88;
        }
        
    }

    if (indexPath.section==3)
    {
        
            if ([[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"messagetype"] isEqualToString:@"TEXT"])
            {
                NSString *text = [[Array_Comment1 objectAtIndex:indexPath.row] valueForKey:@"message"];
                
                CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
                
                CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
                
                CGFloat height = MAX(size.height, 30.0f);
                return height + (CELL_CONTENT_MARGIN * 2)+15;
            }
            else
            {
                CGFloat imgheight=[[[Array_Comment1 objectAtIndex:indexPath.row]valueForKey:@"imageheight"] floatValue];
                return imgheight+14;
            }
        }
    

        return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

if (section==0)
{
    sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,0,0)];
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    
    
    sectionView.tag=section;
    
    
}
if (section==1)
{
    
    sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,40)];
    [sectionView setBackgroundColor:[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1]];
   
    
    
    Button_Contribute=[[UIButton alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width-61,44)];
    
    if (![[[AllArrayData objectAtIndex:0]valueForKey:@"recorded"] isEqualToString:@"yes"] || ![[[AllArrayData objectAtIndex:0]valueForKey:@"recorded"] isEqualToString:@"no"])
    {
        [Button_Contribute setTitle:@"CONTRIBUTE" forState:UIControlStateNormal];
        Button_Contribute.backgroundColor=[UIColor clearColor];
        
        [Button_Contribute addTarget:self action:@selector(Contribute_MoneyAction:)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        
        
        [Button_Contribute setTitle:@"RECORD CHALLENGE" forState:UIControlStateNormal];
        Button_Contribute.backgroundColor=[UIColor colorWithRed:234/255.0 green:36/255.0 blue:39/255.0 alpha:1];
        
        [Button_Contribute addTarget:self action:@selector(Contribute_RecordedChallenge:)
                    forControlEvents:UIControlEventTouchUpInside];
    
    }
    
    Button_Contribute.tag=section;
    Button_Contribute.titleLabel.font=[UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24.0];
   
    
    Image_Share.tag=section;
    
    
    Image_Share=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-61),0,61,44)];
     Image_Share.backgroundColor=[UIColor colorWithRed:20/255.0 green:245/255.0 blue:115/255.0 alpha:1];
    [Image_Share setImage:[UIImage imageNamed:@"sharewithbg.png"]];
    Image_Share.contentMode=UIViewContentModeScaleAspectFit;
     Image_Share.tag=section;
    
    Image_Share.userInteractionEnabled=YES;
    UITapGestureRecognizer * image_shareTab =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Share_Action:)];
    [Image_Share addGestureRecognizer:image_shareTab];
    
    [sectionView addSubview:Button_Contribute];
    [sectionView addSubview:Image_Share];
    
    
    sectionView.tag=section;

    
    
        
        
    }
    if (section==2)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,44)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        
        upperBorder1.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        upperBorder1.frame = CGRectMake(0, 0, sectionView.frame.size.width, 1.0f);
        [sectionView.layer addSublayer:upperBorder1];
        
        
        UILabel * label_Comment=[[UILabel alloc]initWithFrame:CGRectMake(16,0, self.view.frame.size.width-32,30)];
        label_Comment.text=@"Recorded Videos";
        label_Comment.textColor=[UIColor lightGrayColor];
        label_Comment.tag=section;
        label_Comment.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:16.0];
        
        
        
        [sectionView addSubview:label_Comment];
        
        
        sectionView.tag=section;
        
    }
    if (section==3)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,40)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
 
    upperBorder.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
    upperBorder.frame = CGRectMake(0, 0, sectionView.frame.size.width, 1.0f);
    [sectionView.layer addSublayer:upperBorder];
        
        
      UILabel * label_Comment=[[UILabel alloc]initWithFrame:CGRectMake(16,0, self.view.frame.size.width-32,30)];
        label_Comment.text=@"Comments";
        label_Comment.textColor=[UIColor lightGrayColor];
              label_Comment.tag=section;
        label_Comment.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:16.0];
        
       
        
        [sectionView addSubview:label_Comment];
      
        
        sectionView.tag=section;
        
    }
return  sectionView;



}
-(void)Share_Action:(UIGestureRecognizer *)reconizer
{
    
}
-(void)Contribute_RecordedChallenge:(UIButton *)sender
{

    
 Label_confirm1.text=@"0 %";
    strCameraVedio=@"Record";
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    float progress = ((double)totalBytesSent / (double)totalBytesExpectedToSend)*100;
    NSLog(@"percentage  of dattataa==%f",progress);
    Label_confirm1.text=[NSString stringWithFormat:@"%.f%@",progress,@" %"];
}
-(void)Contribute_MoneyAction:(UIButton *)sender
{
ContributeMoneyViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ContributeMoneyViewController"];
    set.total_players=[[AllArrayData objectAtIndex:0]valueForKey:@"noofchallengers"];
    
    set.challengerID=[[AllArrayData objectAtIndex:0]valueForKey:@"challengeid"];
    [self.navigationController pushViewController:set animated:YES];
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section==0)
    {
        return 0;
    }
    if (section==1)
    {
        
            return 44;
       
    }
    if (section==2 )
    {
        
    if (Array_showrecordvid.count==0)
    {
        return 0;
    }
    else
    {
          return 44;
    }
    }
    
    if (section==3)
    {
        
        return 40;
        
    }
    return 0;
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(IBAction)ButtonBack_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)FavouriteTapped_Action:(UIGestureRecognizer *)reconizer
{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Care2dare." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
      
        
        NSString *userid= @"userid";
        NSString *useridVal =[defaults valueForKey:@"userid"];
        
        NSString *challengrid= @"challengeid";
        NSString *challengridVal=[[AllArrayData objectAtIndex:0]valueForKey:@"challengeid"];;
        
        
        
        NSString * reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid,useridVal,challengrid,challengridVal];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"favourite-add"];
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
                                                     
                                                     SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                     NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                     ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                     NSLog(@"Array_WorldExp ResultString %@",ResultString);
//                                                     if ([ResultString isEqualToString:@"nouserid"])
//                                                     {
//                                                         
//                                                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
//                                                         
//                                                         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
//                                                                                                            style:UIAlertActionStyleDefault handler:nil];
//                                                         [alertController addAction:actionOk];
//                                                         [self presentViewController:alertController animated:YES completion:nil];
//                                                         
//                                                     }
                                                     if ([ResultString isEqualToString:@"inserted"])
                                                     {
                                    CheckFavInserted=@"TRUE";
                                    [self.Tableview_ContriBute reloadData];
                                                         
                                                     }
                        if ([ResultString isEqualToString:@"deleted"])
                                                     {
                                                         
                                    CheckFavInserted=@"FALSE";
                                    [self.Tableview_ContriBute reloadData];
                                                     }
                                                     
                                                     
                                                 }
                                                 
                                                 else
                                                 {
                                                    
                                                     NSLog(@" error login1 ---%ld",(long)statusCode);
                                                     
                                                 }
                                                 
                                             }
                                             else if(error)
                                             {
                                                
                                                 NSLog(@"error login2.......%@",error.description);
                                             }
                                         }];
        [dataTask resume];
    }
}
-(void)FlagTapped_Action:(UIGestureRecognizer *)reconizer
{
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    
    if(Array_Comment1.count>=1)
    {
        
        
[Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count-1 inSection:3] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
    }
    
    if (textView.text.length == 0)
    {
        self.sendButton.hidden=NO;
        self.sendButton.enabled=NO;
        self.placeholderLabel.hidden=NO;
        [self.sendButton setBackgroundColor:[UIColor colorWithRed:186/255.0 green:188/255.0 blue:190/255.0 alpha:1]];
        self.sendButton.userInteractionEnabled = NO;
        [self.sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _ImageGalButton.hidden=NO;
        _ImageGalButton.enabled=YES;
        [self.ImageGalButton setBackgroundColor:[UIColor clearColor]];
        self.ImageGalButton.userInteractionEnabled = YES;
        
        
        
        
    }
    else
    {
        
        chattype=@"TEXT";
        
        
        self.placeholderLabel.hidden=YES;
        self.sendButton.hidden=NO;
        self.sendButton.enabled=YES;
        [self.sendButton setBackgroundColor:[UIColor colorWithRed:79/255.0 green:76/255.0 blue:227/255.0 alpha:1]];
        self.sendButton.userInteractionEnabled = YES;
        [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        _ImageGalButton.userInteractionEnabled = NO;
        _ImageGalButton.hidden=NO;
        _ImageGalButton.enabled=NO;
        
    }
    
    
    CGFloat y = CGRectGetMaxY(self.textOne.frame);
    
    UITextPosition* pos = textOne.endOfDocument;
    
    CGRect currentRect = [textOne caretRectForPosition:pos];
    
    NSLog(@"dsdssdfds %f",currentRect.origin.y);
    
    if (currentRect.origin.y >65)
    {
        if ( [flag1 isEqualToString:@"yes" ])
        {
            
            self.BlackViewOne.frame = CGRectMake(0, bty - textView.contentSize.height+26, btw,bth+textView.contentSize.height);
            ViewTextViewOne.frame = CGRectMake(xx, yy, ww,textOne.frame.size.height+2);
            // tableView_Pay.frame = CGRectMake(0, yt - textView.contentSize.height+38, tw, th);
            Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+182));
            flag1=@"no";
        }
        else
        {
            flag1=@"no";
        }
        
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        if(currentRect.origin.y <=64)
        {
            flag1=@"yes";
        }
        
        
        
        self.BlackViewOne.frame = CGRectMake(0, bty - textView.contentSize.height+33, btw,bth+textView.contentSize.height);
        
        self.textOne.frame = CGRectMake(xx, yy, ww,textView.contentSize.height+10);
        ViewTextViewOne.frame = CGRectMake(xx, yy, ww,textView.contentSize.height);
        Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+184));
        
        [self.textOne layoutIfNeeded];
        NSLog(@"BlueView==%f",_textOneBlue.frame.size.height);
        NSLog(@"BlueView==%f",_textOneBlue.frame.size.width);
        NSLog(@"BlueViewx==%f",_textOneBlue.frame.origin.x);
        NSLog(@"BlueViewy==%f",_textOneBlue.frame.origin.y);
        
        
        
        NSLog(@"tableView_Pay==%f",Tableview_ContriBute.frame.size.height);
        NSLog(@"tableView_Payyy==%f",Tableview_ContriBute.frame.origin.y);
        
        NSLog(@"ViewTextViewOne==%f",ViewTextViewOne.frame.size.height);
        
        NSLog(@"self.textOne.frame==%f",self.textOne.frame.size.height);
        
        NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.height);
        NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.size.width);
        NSLog(@"BlackViewOne==%f",_BlackViewOne.frame.origin.y);
        
        NSLog(@"tableOne==%f",Tableview_ContriBute.frame.size.height);
        NSLog(@"tableOne==%f",Tableview_ContriBute.frame.size.width);
        NSLog(@"tableOne==%f",Tableview_ContriBute.frame.origin.y);
        NSLog(@"tableOne==%f",Tableview_ContriBute.frame.origin.x);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_BlackViewOne.frame.size.height > bth)
    {
        Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-_BlackViewOne.frame.size.height+90);
    }
    else
    {
        Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th);
        
    }
    [self.view endEditing:YES];
    
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [textOne becomeFirstResponder];
    
    if (textView.text.length!=0)
    {
        Tableview_ContriBute.frame = CGRectMake(0,yt, self.view.frame.size.width, th-_BlackViewOne.frame.size.height-125);
        
    }
    else
    {
        
        Tableview_ContriBute.frame = CGRectMake(0,yt, tw, th-(textView.contentSize.height+190));
    }
    
    if(Array_Comment1.count>=1)
    {
        
        
    [Tableview_ContriBute scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:Array_Comment1.count-1 inSection:3] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
        
        
    }
    
}
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image  {
    
    
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setupImageViewer];
    imageView.clipsToBounds = YES;
}
-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(void)image_SecProfile_ActionDetails:(UIGestureRecognizer *)reconizer
{
    NSLog(@"Useridd11==%@",[defaults valueForKey:@"userid"]);
    
     NSLog(@"Useridd11==%@",[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid"]);
    
    
    if(![[[AllArrayData objectAtIndex:0] valueForKey:@"challengersuserid"]isEqualToString:@"0"])
  {
      ProfilePageDetailsViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageDetailsViewController"];
      set.userId_prof=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengersuserid"]];
      
      set.user_name=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengersname"]];
      
      set.user_imageUrl=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0]valueForKey:@"challengersprofilepic"]];
      
      set.Images_data=cell_TwoDetails.image_SecProfile;
      [self.navigationController pushViewController:set animated:YES];
  }
    
 
    
}
-(void)ImageTapped_profile:(UIGestureRecognizer *)reconizer
{
    WatchVediosViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"WatchVediosViewController"];
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)reconizer;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
   
    set.str_ChallengeidVal=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0] valueForKey:@"challengeid"]];
    
    set.str_Userid2val=[NSString stringWithFormat:@"%@",[[Array_showrecordvid objectAtIndex:(long)imageView.tag]valueForKey:@"useridvideo"]];
    
 //   set.Str_urlVedio=[NSString stringWithFormat:@"%@",[[Array_showrecordvid objectAtIndex:(long)imageView.tag]valueForKey:@"videourl"]];
    
      set.str_challengeTitle=[NSString stringWithFormat:@"%@",[[AllArrayData objectAtIndex:0] valueForKey:@"title"]];
    set.str_image_Data=imageView;
    [self.navigationController pushViewController:set animated:YES];
}
@end