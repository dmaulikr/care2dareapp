//
//  ContactListViewController.m
//  care2Dare
//
//  Created by Spiel's Macmini on 5/17/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "ContactListViewController.h"
#import <Contacts/Contacts.h>
#import "Reachability.h"
#import "SBJsonParser.h"
#import "UIImageView+WebCache.h"
#import <MessageUI/MessageUI.h>
#import <AddressBook/ABAddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@interface ContactListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString * name,*phoneNumber,*emailAddress;
    NSMutableArray * Array_name,*Array_Email,*Array_Phone,*Array_AllData,*contactlists;
    NSMutableArray * Array_name1,*Array_Email1,*Array_Phone1;
    CNContactStore *store;
    NSDictionary *urlplist;
    NSUserDefaults * defaults;
    CALayer *borderBottom_SectionView0,*borderBottom_SectionView1;
    CALayer *Bottomborder_Cell2;
    NSMutableArray *ArryMerge_twitterlistSection0,*ArryMerge_twitterlistSection1;
    UIView *sectionView;
    NSArray * Array_Add,*array_invite;
    NSMutableArray * Array_searchFriend1,*arrayCount;
}
@end

@implementation ContactListViewController
@synthesize cell_contact,cell_contactAdd,searchbar,indcator;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UrlName" ofType:@"plist"];
    urlplist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    Array_name=[[NSMutableArray alloc]init];
    Array_Email=[[NSMutableArray alloc]init];
    Array_Phone=[[NSMutableArray alloc]init];
    contactlists=[[NSMutableArray alloc]init];
    
    
    Array_searchFriend1=[[NSMutableArray alloc]init];
    borderBottom_SectionView0 = [CALayer layer];
    borderBottom_SectionView1 = [CALayer layer];
    Bottomborder_Cell2 = [CALayer layer];
    searchbar.showsCancelButton=NO;

  //  [indcator startAnimating];
    indcator.hidden=NO;
    [_tableview_contact setHidden:YES];
    store = [[CNContactStore alloc] init];
    [self contactListData];
}

-(IBAction)Button_Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)contactListData
{
    
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    __block BOOL accessGranted = NO;
    
    if (&ABAddressBookRequestAccessWithCompletion != NULL) { // We are on iOS 6
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(semaphore);
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        //        dispatch_release(semaphore);
    }
    
    else { // We are on iOS 5 or Older
        accessGranted = YES;
        [self getContactsWithAddressBook:addressBook];
    }
    
    if (accessGranted) {
        [self getContactsWithAddressBook:addressBook];
    }
    
}
- (void)getContactsWithAddressBook:(ABAddressBookRef )addressBook
{
    
    contactlists = [[NSMutableArray alloc] init];
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    for (int i=0;i < nPeople;i++) {
        NSMutableDictionary *dOfPerson=[NSMutableDictionary dictionary];
        
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople,i);
        
        //For username and surname
        ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(ref, kABPersonPhoneProperty));
        
        CFStringRef firstName, lastName;
        firstName = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        lastName  = ABRecordCopyValue(ref, kABPersonLastNameProperty);
        // [dOfPerson setObject:[NSString stringWithFormat:@"%@ %@", firstName, lastName] forKey:@"name"];
        if (firstName !=nil && lastName==nil)
        {
            [dOfPerson setObject:[NSString stringWithFormat:@"%@", firstName] forKey:@"name"];
        }
        else if (firstName ==nil && lastName !=nil)
        {
            [dOfPerson setObject:[NSString stringWithFormat:@"%@", lastName] forKey:@"name"];
        }
        else if (firstName !=nil && lastName !=nil)
        {
            [dOfPerson setObject:[NSString stringWithFormat:@"%@%@%@", firstName,@" " ,lastName] forKey:@"name"];
        }
        // For getting the user image.
        UIImage *contactImage;
        if(ABPersonHasImageData(ref)){
            contactImage = [UIImage imageWithData:(__bridge NSData *)ABPersonCopyImageData(ref)];
        }
        
        //For Email ids
        ABMutableMultiValueRef eMail  = ABRecordCopyValue(ref, kABPersonEmailProperty);
        if(ABMultiValueGetCount(eMail) > 0) {
            [dOfPerson setObject:(__bridge NSString *)ABMultiValueCopyValueAtIndex(eMail, 0) forKey:@"email"];
            
        }
        
        //For Phone number
        NSString* mobileLabel;
        
        for(CFIndex i = 0; i < ABMultiValueGetCount(phones); i++) {
            mobileLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phones, i);
            if([mobileLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
            }
            
            else if ([mobileLabel isEqualToString:(NSString*)kABPersonPhoneIPhoneLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
                break ;
            }
            
        }
        if (dOfPerson.count>=2)
        {
            if ([dOfPerson objectForKey:@"name"] &&  [dOfPerson valueForKey:@"name"] !=nil)
            {
                [Array_name addObject:[dOfPerson valueForKey:@"name"]];
                if ([dOfPerson valueForKey:@"email"]==nil)
                {
                    [Array_Email addObject:@""];
                }
                else
                {
                    [Array_Email addObject:[dOfPerson valueForKey:@"email"]];
                }
                if ([dOfPerson valueForKey:@"Phone"]==nil)
                {
                    [Array_Phone addObject:@""];
                }
                else
                {
                    [Array_Phone addObject:[dOfPerson valueForKey:@"Phone"]];
                }
                [contactlists addObject:dOfPerson];
            }
            
        }
        
    }
    if (Array_name.count!=0)
    {
        for (int i=0; i<Array_name.count; i++)
        {
            
        }
        Array_name1=[[NSMutableArray alloc]init];
        Array_Email1=[[NSMutableArray alloc]init];
        Array_Phone1=[[NSMutableArray alloc]init];
        
        [self ContactCommunication];
        
    }
    else
    {
        [self contactListData];
    }
    NSLog(@"Contacts = %@",contactlists);
    // [contactlists removeObjectsInRange:NSMakeRange(0, 10)];
    // [contactlists subarrayWithRange:NSMakeRange(0, 5)];
    //    NSLog(@"Contacts = %@",[contactlists subarrayWithRange:NSMakeRange(0,10)]);
    NSLog(@"Array_Phone = %@",Array_Phone);
    NSLog(@"Array_Email = %@",Array_Email);
    NSLog(@"Array_name = %@",Array_name);
}


-(void)contactListData11
{
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error)
     {
         if (granted == YES)
         {
             //keys with fetching properties
             NSArray *keys = @[CNContactFamilyNameKey,CNContactEmailAddressesKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
             NSString *containerId = store.defaultContainerIdentifier;
             NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
             NSError *error;
             NSArray *cnContacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
             if (error)
             {
                 NSLog(@"error fetching contacts %@", error);
             } else
             {
                 for (CNContact *contact in cnContacts)
                 {
                     NSLog(@"Contacts123== %@",contact);
                     NSLog(@"Name== %@%@%@", contact.givenName,@" ",contact.familyName);
                     name=[NSString stringWithFormat:@"%@%@%@", contact.givenName,@" ",contact.familyName];
                     
                     for (CNLabeledValue * label in contact.emailAddresses)
                     {
                         NSString *Email = label.value;
                         if ([Email length] > 0)
                         {
                             emailAddress=[NSString stringWithFormat:@"%@",Email];
                             
                             
                             NSLog(@"Email==%@", Email);
                         }
                     }
                     
                     for (CNLabeledValue *label in contact.phoneNumbers)
                     {
                         NSString *phone = [label.value stringValue];
                         if ([phone length] > 0)
                         {
                             phoneNumber=[NSString stringWithFormat:@"%@",phone];
                             NSLog(@"phone=== %@", phone);
                         }
                     }
                     
                     // NSMutableDictionary *Contact_dict = [[NSMutableDictionary alloc] init];
                     if ((name !=nil && ![name isEqualToString:@" "]) && ((emailAddress !=nil && ![emailAddress isEqualToString:@""])||(phoneNumber !=nil && ![phoneNumber isEqualToString:@""])))
                     {
                         // [Contact_dict setObject:name forKey:@"name"];
                         [Array_name addObject:name];
                         
                         if (phoneNumber !=nil && ![phoneNumber isEqualToString:@""])
                         {
                             // [Contact_dict setObject:phoneNumber forKey:@"phone"];
                             phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
                             
                             phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
                             [Array_Phone addObject:phoneNumber];
                         }
                         else
                         {
                             //[Contact_dict setObject:@"" forKey:@"phone"];
                             [Array_Phone addObject:@""];
                         }
                         if (emailAddress !=nil && ![emailAddress isEqualToString:@""])
                         {
                             //[Contact_dict setObject:emailAddress forKey:@"email"];
                             [Array_Email addObject:emailAddress];
                         }
                         else
                         {
                             //[Contact_dict setObject:@"" forKey:@"email"];
                             [Array_Email addObject:@""];
                         }
                         
                         
                         //                    if ((emailAddress !=nil && ![emailAddress isEqualToString:@""]) || (phoneNumber !=nil && ![phoneNumber isEqualToString:@""]) )
                         //                    {
                         //                         [Array_contatList addObject:Contact_dict];
                         //                    }
                         
                         
                     }
                     name=nil;
                     emailAddress=nil;
                     phoneNumber=nil;
                 }
                 
                 NSLog(@"Array_Email==%@", Array_Email);
                 NSLog(@"Array_Phone==%@", Array_Phone);
                 NSLog(@"Array_name==%@", Array_name);
                 if (Array_name.count!=0)
                 {
                     [self ContactCommunication];
                 }
             }
         }
     }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0)
    {
        
        return ArryMerge_twitterlistSection0.count;
    }
    if (section==1)
    {
        return ArryMerge_twitterlistSection1.count;
    }
    
    return 0;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 44;
    }
    if (indexPath.section==1)
    {
        NSDictionary * dictVal=[ArryMerge_twitterlistSection1 objectAtIndex:indexPath.row];
        
        if ([[dictVal valueForKey:@"friendmobileno"] isEqualToString:@""] && ![[dictVal valueForKey:@"friendemail"] isEqualToString:@""])
        {
            return 47;
        }
        if (![[dictVal valueForKey:@"friendmobileno"] isEqualToString:@""] && [[dictVal valueForKey:@"friendemail"] isEqualToString:@""])
        {
            return 47;
        }
        if (![[dictVal valueForKey:@"friendmobileno"] isEqualToString:@""] && ![[dictVal valueForKey:@"friendemail"] isEqualToString:@""])
        {
            return 67;
        }
        
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellone=@"CellCon";
    static NSString *celltwo=@"Celladd";
    switch (indexPath.section)
    {
        case 0:
        {
            cell_contactAdd = (ContactAddTableViewCell *)[tableView dequeueReusableCellWithIdentifier:celltwo forIndexPath:indexPath];
            if (ArryMerge_twitterlistSection0.count-1==indexPath.row)
            {
                Bottomborder_Cell2 = [CALayer layer];
                Bottomborder_Cell2.backgroundColor = [UIColor clearColor].CGColor;
                Bottomborder_Cell2.frame = CGRectMake(0, cell_contactAdd.frame.size.height-1, cell_contactAdd.frame.size.width, 1);
                [cell_contactAdd.layer addSublayer:Bottomborder_Cell2];
            }
            else
            {
                
                Bottomborder_Cell2 = [CALayer layer];
                Bottomborder_Cell2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
                Bottomborder_Cell2.frame = CGRectMake(0, cell_contactAdd.frame.size.height-1,cell_contactAdd.frame.size.width, 1);
                [cell_contactAdd.layer addSublayer:Bottomborder_Cell2];
                
                
            }
            
            NSDictionary * dictVal=[ArryMerge_twitterlistSection0 objectAtIndex:indexPath.row];
            cell_contactAdd.Button_Add.tag=indexPath.row;
            cell_contactAdd.label_fbname.text=[dictVal valueForKey:@"name"];
            NSURL * url=[NSURL URLWithString:[dictVal valueForKey:@"imageurl"]];
            [cell_contactAdd.image_profile_img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImg.jpg"] options:SDWebImageRefreshCached];
            
            [cell_contactAdd.image_profile_img setFrame:CGRectMake(cell_contactAdd.image_profile_img.frame.origin.x, cell_contactAdd.image_profile_img.frame.origin.y, cell_contactAdd.image_profile_img.frame.size.height, cell_contactAdd.image_profile_img.frame.size.height)];
            [cell_contactAdd.Button_Add addTarget:self action:@selector(AddUser:) forControlEvents:UIControlEventTouchUpInside];
            cell_contactAdd.Button_Add.clipsToBounds=YES;
            cell_contactAdd.Button_Add.layer.cornerRadius=7.0f;
            
            return cell_contactAdd;
            
            
        }
            break;
            
        case 1:
        {
            cell_contact = (ContactTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellone forIndexPath:indexPath];
            
//            if (ArryMerge_twitterlistSection1.count-1==indexPath.row)
//            {
//                Bottomborder_Cell2 = [CALayer layer];
//                Bottomborder_Cell2.backgroundColor = [UIColor clearColor].CGColor;
//                Bottomborder_Cell2.frame = CGRectMake(0, cell_contact.frame.size.height-1, cell_contact.frame.size.width, 1);
//                [cell_contact.layer addSublayer:Bottomborder_Cell2];
//            }
//            else
//            {
//                
//                Bottomborder_Cell2 = [CALayer layer];
//                Bottomborder_Cell2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
//                Bottomborder_Cell2.frame = CGRectMake(0, cell_contact.frame.size.height-1,cell_contact.frame.size.width, 1);
//                [cell_contact.layer addSublayer:Bottomborder_Cell2];
//                
//                
//            }
            
            
            cell_contact.button_invite.tag=indexPath.row;
            NSDictionary * dictVal=[ArryMerge_twitterlistSection1 objectAtIndex:indexPath.row];
            cell_contact.label_one.text=[dictVal valueForKey:@"name"];
            if ([[dictVal valueForKey:@"friendmobileno"] isEqualToString:@""] && ![[dictVal valueForKey:@"friendemail"] isEqualToString:@""])
            {
               // [cell_contact.button_invite addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
                cell_contact.label_two.text=[dictVal valueForKey:@"friendemail"];
                cell_contact.label_three.hidden=YES;
            }
            if (![[dictVal valueForKey:@"friendmobileno"] isEqualToString:@""] && [[dictVal valueForKey:@"friendemail"] isEqualToString:@""])
            {
               // [cell_contact.button_invite addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
                cell_contact.label_two.text=[dictVal valueForKey:@"friendmobileno"];
                cell_contact.label_three.hidden=YES;
            }
            if (![[dictVal valueForKey:@"friendmobileno"] isEqualToString:@""] && ![[dictVal valueForKey:@"friendemail"] isEqualToString:@""])
            {
               // [cell_contact.button_invite addTarget:self action:@selector(InviteUser:) forControlEvents:UIControlEventTouchUpInside];
                cell_contact.label_two.text=[dictVal valueForKey:@"friendmobileno"];
                cell_contact.label_three.text=[dictVal valueForKey:@"friendemail"];
                cell_contact.label_three.hidden=NO;
            }
            //cell_contact.label_two.text=[dictVal valueForKey:@"friendemail"];
            // cell_contact.label_three.text=[dictVal valueForKey:@"friendmobileno"];
            
            [cell_contact.button_invite addTarget:self action:@selector(InviteUser:) forControlEvents:UIControlEventTouchUpInside];
            
            cell_contact.button_invite.clipsToBounds=YES;
            cell_contact.button_invite.layer.cornerRadius=7.0f;
            
            return cell_contact;
            
            
        }
            break;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,40)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        
        borderBottom_SectionView0.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_SectionView0.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width, 1);
        [sectionView.layer addSublayer:borderBottom_SectionView0];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, sectionView.frame.size.height)];
        //        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"Add Friends";
        [sectionView addSubview:Label1];
        sectionView.tag=section;
        
    }
    if (section==1)
    {
        
        sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,40)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel * Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,0, self.view.frame.size.width-40, sectionView.frame.size.height)];
        //        Label1.backgroundColor=[UIColor clearColor];
        Label1.textColor=[UIColor lightGrayColor];
        Label1.font=[UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:15.0f];
        Label1.text=@"Invite Friends";
        [sectionView addSubview:Label1];
        
        sectionView.tag=section;
        borderBottom_SectionView1.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        borderBottom_SectionView1.frame = CGRectMake(0, sectionView.frame.size.height-1, sectionView.frame.size.width, 1);
        [sectionView.layer addSublayer:borderBottom_SectionView1];
        
        
        
    }
    //   if (section==3)
    //    {
    //
    //
    //    }
    //
    
    return  sectionView;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        if (ArryMerge_twitterlistSection0.count==0)
        {
            return 0;
        }
        else
        {
            return 40;
        }
    }
    if (section==1)
    {
        if (ArryMerge_twitterlistSection1.count==0)
        {
            return 0;
        }
        else
        {
            return 40;
        }
    }
    return 0;
    
    
}
-(void)ContactCommunication
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
        NSString *namestr= @"name";
        NSString *emailstr= @"email";
        NSString *mobilenumber= @"mobileno";
        NSString *namestrval,*emailstrval,*mobilenumberval,*escapedNameString;
        if (Array_name.count !=0)
        {
            if (Array_name.count<=180)
            {
                namestrval =[[Array_name subarrayWithRange:NSMakeRange(0,[Array_name count])] componentsJoinedByString:@","];;
                emailstrval=[[Array_Email subarrayWithRange:NSMakeRange(0,[Array_Email count])] componentsJoinedByString:@","];;
                mobilenumberval=[[Array_Phone subarrayWithRange:NSMakeRange(0,[Array_Phone count])] componentsJoinedByString:@","];;
            }
            else
            {
                
                NSArray * arrayCount1=[[NSArray alloc]init];
                arrayCount1 =[Array_name subarrayWithRange:NSMakeRange(0,180)];
                NSLog(@"Arra counts===%lu",(unsigned long)arrayCount1.count);
                namestrval =[[Array_name subarrayWithRange:NSMakeRange(0,180)] componentsJoinedByString:@","];;
                emailstrval=[[Array_Email subarrayWithRange:NSMakeRange(0,180)] componentsJoinedByString:@","];;
                mobilenumberval=[[Array_Phone subarrayWithRange:NSMakeRange(0,180)] componentsJoinedByString:@","];;
                
                
            }
        }
        
        
        
        
        
        NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[urlplist valueForKey:@"invite_contacts"]]];
        [req setHTTPMethod:@"POST"];
        
        NSString *str=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",userid,useridVal,namestr,namestrval,emailstr,emailstrval,mobilenumber,mobilenumberval];
        
        NSData *postData = [str dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        [req addValue:postLength forHTTPHeaderField:@"Content-Length"];
        [req setHTTPBody:postData];
        NSURLSession *session = [NSURLSession sharedSession];
        
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:req
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if(data)
                                                    {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                        NSInteger statusCode = httpResponse.statusCode;
                                                        if(statusCode == 200)
                                                        {
                                                            Array_AllData=[[NSMutableArray alloc]init];
                                                            SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                                            Array_AllData=[objSBJsonParser objectWithData:data];
                                                            
                                                            NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                            
                                                                                    
                                                            
                                                                                        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                                                                
                                                                                                ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                                                                
                                                                                                                     NSLog(@"ResultString %@",ResultString);
     
                                                            
                        if ([ResultString isEqualToString:@"done"])
                                {
                            if (Array_name.count>=180)
                                                {
                            [Array_name removeObjectsInRange:NSMakeRange(0, 180)];
                            [Array_Email removeObjectsInRange:NSMakeRange(0, 180)];
                            [Array_Phone removeObjectsInRange:NSMakeRange(0, 180)];
                                                                    
                                            }
                                            else
                                            {
                            [Array_name removeObjectsInRange:NSMakeRange(0, [Array_name count])];
                            [Array_Email removeObjectsInRange:NSMakeRange(0,[Array_Email count])];
                            [Array_Phone removeObjectsInRange:NSMakeRange(0, [Array_Phone count])];
                                                                    
                                    }
                                                                
                                                               
                                                                
                                                                
                                                                
                                if (Array_name.count !=0)
                                        {
                                        [self ContactCommunication];
                                        }
                                        else
                                            {
                                                                    
                                                                    
//                                                                    
//                                                                    ArryMerge_twitterlistSection0=[[NSMutableArray alloc]init];
//                                                                    ArryMerge_twitterlistSection1=[[NSMutableArray alloc]init];
//                                                                    Array_Add=[[NSArray alloc]init];
//                                                                    array_invite=[[NSArray alloc]init];
//                                                                    
//                                                                    
//                                                                    for (int i=0; i<Array_AllData.count; i++)
//                                                                    {
//                                                                        if ([[[Array_AllData objectAtIndex:i]valueForKey:@"status"] isEqualToString:@"INVITE"])
//                                                                        {
//                                                                            [ArryMerge_twitterlistSection1 addObject:[Array_AllData objectAtIndex:i]];
//                                                                            
//                                                                        }
//                                                                        else if([[[Array_AllData objectAtIndex:i]valueForKey:@"status"] isEqualToString:@"ADD"])
//                                                                        {
//                                                                            [ArryMerge_twitterlistSection0 addObject:[Array_AllData objectAtIndex:i]];
//                                                                        }
//                                                                        
//                                                                    }
//                                                                    array_invite=[ArryMerge_twitterlistSection1 mutableCopy];
//                                                                    Array_Add=[ArryMerge_twitterlistSection0 mutableCopy];
                                                
                                                [self showAllContacts];
                                                
                                                                    
                                  
                                                                    
//                                                                   indcator.hidden=YES;
//                                                [_tableview_contact setHidden:NO];
//                                                                    
//                                            [indcator stopAnimating];
//            NSIndexPath *myIP = [NSIndexPath indexPathForRow:[ArryMerge_twitterlistSection1 count]-1 inSection:1] ;
//                                                                    
//            [_tableview_contact scrollToRowAtIndexPath:myIP atScrollPosition:NULL animated:NO];
                                                


                                                                
                                                                }
                                                                
 
                                                            }
                                                        }
                                                        else
                                                        {
                                    //[self ContactCommunication];
                                                            if (Array_name.count !=0)
                                                            {
                                            [self ContactCommunication];
                                                            }
                            NSLog(@" error login1 ---%ld",(long)statusCode);
    
                                                        }
                                                        
                                                    }
                                                }];
        
        
        [task resume];
        
    }
    
        
//        
//            NSString *userid= @"userid";
//            NSString *useridVal =[defaults valueForKey:@"userid"];
//            NSString *namestr= @"name";
//            NSString *namestrval =[Array_name componentsJoinedByString:@","];;
//            NSString *emailstr= @"email";
//            NSString *emailstrval =[Array_Email componentsJoinedByString:@","];;
//            NSString *mobilenumber= @"mobileno";
//            NSString *mobilenumberval =[Array_Phone componentsJoinedByString:@","];;
//    
//        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",userid,useridVal,namestr,namestrval,emailstr,emailstrval,mobilenumber,mobilenumberval];
//    
//    #pragma mark - swipe sesion
//    
//            NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
//    
//            NSURL *url;
//            NSString *  urlStrLivecount=[urlplist valueForKey:@"invite_contacts"];;
//            url =[NSURL URLWithString:urlStrLivecount];
//    
//            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    
//            [request setHTTPMethod:@"POST"];//Web API Method
//    
//            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    
//            request.HTTPBody = [reqStringFUll dataUsingEncoding:NSUTF8StringEncoding];
//    
//    
//    
//            NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
//                                             {
//                                                 if(data)
//                                                 {
//                                                     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//                                                     NSInteger statusCode = httpResponse.statusCode;
//                                                     if(statusCode == 200)
//                                                     {
//    
//                                    Array_AllData=[[NSMutableArray alloc]init];
//                                SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
//                                Array_AllData=[objSBJsonParser objectWithData:data];
//    
//                                NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    
//                                                         //Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
//    
//                            ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    
//                                    ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//    
//                                                         NSLog(@"Array_AllData %@",Array_AllData);
//    
//    
//                                                         NSLog(@"Array_AllData ResultString %@",ResultString);
//    
//    
//                                    if (Array_AllData.count !=0)
//                                        {
//                                        ArryMerge_twitterlistSection0=[[NSMutableArray alloc]init];
//                                        ArryMerge_twitterlistSection1=[[NSMutableArray alloc]init];
//                                Array_Add=[[NSArray alloc]init];
//                                array_invite=[[NSArray alloc]init];
//    
//    //                                                             [tableview_twitter setHidden:YES];
//    //                                                             indicator.hidden=YES;
//    //                                                             [indicator stopAnimating];
//    //                                                             Lable_JSONResult.hidden=NO;
//    //
//                                             for (int i=0; i<Array_AllData.count; i++)
//                                                {
//                                        if ([[[Array_AllData objectAtIndex:i]valueForKey:@"status"] isEqualToString:@"INVITE"])
//                                                    {
//                                        [ArryMerge_twitterlistSection1 addObject:[Array_AllData objectAtIndex:i]];
//    
//                                                }
//                            else if([[[Array_AllData objectAtIndex:i]valueForKey:@"status"] isEqualToString:@"ADD"])
//                                    {
//                                    [ArryMerge_twitterlistSection0 addObject:[Array_AllData objectAtIndex:i]];
//                                    }
//    
//                                            }
//                                            array_invite=[ArryMerge_twitterlistSection1 mutableCopy];
//                                            Array_Add=[ArryMerge_twitterlistSection0 mutableCopy];
//                                            [indcator stopAnimating];
//                                        [_tableview_contact reloadData];
//    
//                                        }
//    
//    
//                                    if ([ResultString isEqualToString:@"phoneNumber"])
//                                        {
//    
//                                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Your account does not exist or seems to have been suspended. Please contact admin." preferredStyle:UIAlertControllerStyleAlert];
//    
//                                    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
//                                        style:UIAlertActionStyleDefault handler:nil];
//                                        [alertController addAction:actionOk];
//                                    [self presentViewController:alertController animated:YES completion:nil];
//    
//    
//                                                         }
//                                                     }
//    
//                                                     else
//                                                     {
//                                                         NSLog(@" error login1 ---%ld",(long)statusCode);
//    
//                                                     }
//    
//                                                 }
//                                                 else if(error)
//                                                 {
//    
//                                                     NSLog(@"error login2.......%@",error.description);
//    
//                                                 }
//                                             }];
//            [dataTask resume];
//        }
//    
}
-(void)showAllContacts
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
        
            NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@",userid,useridVal];
    
        #pragma mark - swipe sesion
    
                NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
                NSURL *url;
                NSString *  urlStrLivecount=[urlplist valueForKey:@"show_contacts"];;
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
    
                                        Array_AllData=[[NSMutableArray alloc]init];
                                    SBJsonParser *objSBJsonParser = [[SBJsonParser alloc]init];
                                    Array_AllData=[objSBJsonParser objectWithData:data];
    
                                    NSString * ResultString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
                                                             //Array_LodingPro=[NSJSONSerialization JSONObjectWithData:webData_Swipe options:kNilOptions error:nil];
    
                                ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
                                        ResultString = [ResultString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
                                                             NSLog(@"Array_AllData %@",Array_AllData);
    
    
                                                             NSLog(@"Array_AllData ResultString %@",ResultString);
    
    
                                        if (Array_AllData.count !=0)
                                            {
                        ArryMerge_twitterlistSection0=[[NSMutableArray alloc]init];
                                            ArryMerge_twitterlistSection1=[[NSMutableArray alloc]init];
                                    Array_Add=[[NSArray alloc]init];
                                    array_invite=[[NSArray alloc]init];
    
     for (int i=0; i<Array_AllData.count; i++)
                {
                    if ([[[Array_AllData objectAtIndex:i]valueForKey:@"status"] isEqualToString:@"INVITE"])
                                {
                [ArryMerge_twitterlistSection1 addObject:[Array_AllData objectAtIndex:i]];
    
                        }
            else if([[[Array_AllData objectAtIndex:i]valueForKey:@"status"] isEqualToString:@"ADD"])
                        {
        [ArryMerge_twitterlistSection0 addObject:[Array_AllData objectAtIndex:i]];
                        }
    
                }
                array_invite=[ArryMerge_twitterlistSection1 mutableCopy];
                Array_Add=[ArryMerge_twitterlistSection0 mutableCopy];
            [indcator stopAnimating];
            [_tableview_contact setHidden:NO];
                        [_tableview_contact reloadData];
    
                        }
    
    
                if ([ResultString isEqualToString:@"nocontacts"])
                                            {
    
                                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"no friends" preferredStyle:UIAlertControllerStyleAlert];
        
                                        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                            style:UIAlertActionStyleDefault handler:nil];
                                            [alertController addAction:actionOk];
                                        [self presentViewController:alertController animated:YES completion:nil];
        
        
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



-(void)InviteUser:(UIButton *)sender
{
    
    
    
    NSDictionary * dictVal=[ArryMerge_twitterlistSection1 objectAtIndex:sender.tag];
    
    if ([[dictVal valueForKey:@"friendmobileno"] isEqualToString:@""] && ![[dictVal valueForKey:@"friendemail"] isEqualToString:@""])
    {
        
        if (![MFMailComposeViewController canSendMail])
        {
            NSLog(@"Mail services are not available");
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please configure your mailbox in order to invite a friend." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            return;
        }
        else
        {
            MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
            mailCont.mailComposeDelegate = self;
            [mailCont setToRecipients:[NSArray arrayWithObject:[[ArryMerge_twitterlistSection1 objectAtIndex:sender.tag]valueForKey:@"friendemail"]]];
            
            [mailCont setSubject:@"Download Play:Date"];
            [mailCont setMessageBody:@"Hey, \n\n Play:Date is a great app to find friends for your children. I have been using it since a while, and it would be great if you could download it! \n\n Visit http://www.play-date.ae to download it on your mobile phone! \n\n Thanks!" isHTML:NO];
            
            [self presentViewController:mailCont animated:YES completion:nil];
            
        }
        
        
        
    }
    if (![[dictVal valueForKey:@"friendmobileno"] isEqualToString:@""] && [[dictVal valueForKey:@"friendemail"] isEqualToString:@""])
        
    {
        if([MFMessageComposeViewController canSendText]) {
            MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init]; // Create message VC
            messageController.messageComposeDelegate = self; // Set delegate to current instance
            
            NSMutableArray *recipients = [[NSMutableArray alloc] init]; // Create an array to hold the recipients
            [recipients addObject:[[ArryMerge_twitterlistSection1 objectAtIndex:sender.tag]valueForKey:@"friendmobileno"]]; // Append example phone number to array
            messageController.recipients = recipients; // Set the recipients of the message to the created array
            
            
            
            messageController.body = @"Play:Date is a great app to find friends for your children. I have been using it since a while, and it would be great if you could download it! \n\n Visit http://www.play-date.ae to download it on your mobile phone!"; // Set initial text to example message
            
            dispatch_async(dispatch_get_main_queue(), ^{ // Present VC when possible
                [self presentViewController:messageController animated:YES completion:NULL];
            });
        }
    }
    
    if (![[dictVal valueForKey:@"friendmobileno"] isEqualToString:@""] && ![[dictVal valueForKey:@"friendemail"] isEqualToString:@""])
    {
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email Address",@"Phone Number",nil];
        popup.tag = sender.tag;
        [popup showInView:self.view];
        
        
    }
    
    
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    if ((long)actionSheet.tag == 707)
    //    {
    NSLog(@"INDEX==%ld",(long)buttonIndex);
    
    if (buttonIndex== 0)
    {
        if (![MFMailComposeViewController canSendMail])
        {
            NSLog(@"Mail services are not available");
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please configure your mailbox in order to invite a friend." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            return;
        }
        else
        {
            MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
            mailCont.mailComposeDelegate = self;
            [mailCont setToRecipients:[NSArray arrayWithObject:[[ArryMerge_twitterlistSection1 objectAtIndex:(long)actionSheet.tag]valueForKey:@"friendemail"]]];
            
            [mailCont setSubject:@"Download Play:Date"];
            [mailCont setMessageBody:@"Hey, \n\n Play:Date is a great app to find friends for your children. I have been using it since a while, and it would be great if you could download it! \n\n Visit http://www.play-date.ae to download it on your mobile phone! \n\n Thanks!" isHTML:NO];
            
            [self presentViewController:mailCont animated:YES completion:nil];
            
        }
        
        
    }
    else  if (buttonIndex== 1)
    {
        if([MFMessageComposeViewController canSendText]) {
            MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init]; // Create message VC
            messageController.messageComposeDelegate = self; // Set delegate to current instance
            
            NSMutableArray *recipients = [[NSMutableArray alloc] init]; // Create an array to hold the recipients
            [recipients addObject:[[ArryMerge_twitterlistSection1 objectAtIndex:(long)actionSheet.tag]valueForKey:@"friendmobileno"]]; // Append example phone number to array
            messageController.recipients = recipients; // Set the recipients of the message to the created array
            
            
            
            messageController.body = @"Play:Date is a great app to find friends for your children. I have been using it since a while, and it would be great if you could download it! \n\n Visit http://www.play-date.ae to download it on your mobile phone!"; // Set initial text to example message
            
            dispatch_async(dispatch_get_main_queue(), ^{ // Present VC when possible
                [self presentViewController:messageController animated:YES completion:NULL];
            });
        }
    }
}

-(void)sendEmail:(UIButton *)sender
{
    if (![MFMailComposeViewController canSendMail])
    {
        NSLog(@"Mail services are not available");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Please configure your mailbox in order to invite a friend." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    else
    {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        [mailCont setToRecipients:[NSArray arrayWithObject:[[ArryMerge_twitterlistSection1 objectAtIndex:sender.tag]valueForKey:@"friendemail"]]];
        [mailCont setSubject:@"Download care2dare"];
        [mailCont setMessageBody:@"Hey,\n\nChallenge your friends to a dare and help contribute to the society! \n\nVisit http://www.care2dare.com to download it on your mobile phone!\n\nThanks!" isHTML:NO];
        [self presentViewController:mailCont animated:YES completion:nil];
        
    }
    
    
}
-(void)sendMessage:(UIButton *)sender
{
    if([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init]; // Create message VC
        messageController.messageComposeDelegate = self; // Set delegate to current instance
        
        NSMutableArray *recipients = [[NSMutableArray alloc] init]; // Create an array to hold the recipients
        [recipients addObject:[[ArryMerge_twitterlistSection1 objectAtIndex:sender.tag]valueForKey:@"friendmobileno"]]; // Append example phone number to array
        messageController.recipients = recipients; // Set the recipients of the message to the created array
        
        messageController.body = @"Challenge your friends to a dare and help contribute to the society! Visit http://www.care2dare.com to download it on your mobile phone!"; // Set initial text to example message
        
        dispatch_async(dispatch_get_main_queue(), ^{ // Present VC when possible
            [self presentViewController:messageController animated:YES completion:NULL];
        });
    }
}
-(void)AddUser:(UIButton *)sender
{
    
    
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
        
        
        NSString *userid1= @"userid1";
        NSString *useridval1= [defaults valueForKey:@"userid"];
        
        NSString *userid2= @"userid2";
        NSString * userId_prof=[[ArryMerge_twitterlistSection0 valueForKey:@"frienduserid"]objectAtIndex:sender.tag];
        
        
        NSString *reqStringFUll=[NSString stringWithFormat:@"%@=%@&%@=%@",userid1,useridval1,userid2,userId_prof];
        
        
        
#pragma mark - swipe sesion
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration] delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url;
        NSString *  urlStrLivecount=[urlplist valueForKey:@"addfriend"];;
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
                                                     
                                                     
                                                     if ([ResultString isEqualToString:@"requested"])
                                                     {
                                                         
                                                         
                                                         [self ContactCommunication];
                                                         
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
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    searchbar.showsCancelButton=YES;
    NSArray * Array_searchFriend=[[array_invite arrayByAddingObjectsFromArray:Array_Add]mutableCopy];
    if (searchText.length==0)
    {
        
        [Array_searchFriend1 removeAllObjects];
        [ArryMerge_twitterlistSection0 removeAllObjects];
        [ArryMerge_twitterlistSection1 removeAllObjects];
        
        [Array_searchFriend1 addObjectsFromArray:Array_searchFriend];
        [ArryMerge_twitterlistSection0 addObjectsFromArray:Array_Add];
        [ArryMerge_twitterlistSection1 addObjectsFromArray:array_invite];
        
    }
    else
        
    {
        
        [Array_searchFriend1 removeAllObjects];
        [ArryMerge_twitterlistSection0 removeAllObjects];
        [ArryMerge_twitterlistSection1 removeAllObjects];
        
        for (NSDictionary *book in Array_searchFriend)
        {
            NSString * string=[book objectForKey:@"name"];
            
            NSRange r=[string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (r.location !=NSNotFound )
            {
                
                [Array_searchFriend1 addObject:book];
                
            }
            
        }
        for (int i=0; i<Array_searchFriend1.count; i++)
        {
            if ([[[Array_searchFriend1 objectAtIndex:i]valueForKey:@"status"] isEqualToString:@"ADD"])
            {
                [ArryMerge_twitterlistSection0 addObject:[Array_searchFriend1 objectAtIndex:i]];
            }
            else
            {
                [ArryMerge_twitterlistSection1 addObject:[Array_searchFriend1 objectAtIndex:i]];
            }
        }
        
    }
    
    
    
    [_tableview_contact reloadData];
    
    
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchbar.showsCancelButton=NO;
    [self.view endEditing:YES];
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            //            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

@end
