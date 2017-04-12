//
//  AccptTwoTableViewCell.m
//  care2Dare
//
//  Created by Spiel's Macmini on 4/1/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "AccptTwoTableViewCell.h"

@implementation AccptTwoTableViewCell
@synthesize image_Profile;
- (void)awakeFromNib {
    [super awakeFromNib];
    image_Profile.clipsToBounds=YES;
    image_Profile.layer.cornerRadius=image_Profile.frame.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end