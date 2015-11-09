//
//  UniversityListViewController.h
//  GoToCollege
//
//  Created by Kavana Anand on 11/8/15.
//  Copyright © 2015 Kavana Anand. All rights reserved.
//

#import "BaseViewController.h"

@interface UniversityListViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate> {
    
}
@property (nonatomic,strong) NSArray *tableArray;
@end
