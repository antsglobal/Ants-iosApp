//
//  MeetingsViewController.swift
//  ANTSDemo
//  Created by Kranthi on 10/31/19.
//  Copyright © 2019 Kranthi. All rights reserved.
//

import UIKit
import EventKit
import MSGraphClientSDK
import MSGraphClientModels

class MeetingsViewController: UIViewController{
    @IBOutlet weak var nextBtnClickTag: UIButton!
    @IBOutlet weak var previousBtnClickTag: UIButton!
    
    @IBOutlet weak var upcomingMeetingImg: UIImageView!
    @IBOutlet weak var JTCalendarCollectionView: JTACMonthView!
    @IBOutlet weak var meetingListTableView: UITableView!
    @IBOutlet weak var todayLbl: UILabel!
    @IBOutlet weak var todayImg: UIImageView!
    @IBOutlet weak var completedLbl: UILabel!
    @IBOutlet weak var completedImg: UIImageView!
    @IBOutlet weak var upComingLbl: UILabel!
    
    @IBOutlet weak var monthLabel:UILabel!
    
    var customCalendar = Calendar.current
    private var events: [MSGraphEvent]?
    var menuVc:MenuViewController!
    fileprivate let formatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy MM dd"
           return formatter
       }()
       var startDate = "2015 01 01"
       var endDate = "2099 01 01"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        menuVc = self.storyboard?.instantiateViewController(identifier:"MenuViewController" ) as? MenuViewController
       
        upcomingMeetingImg.layer.borderWidth = 1
                      upcomingMeetingImg.layer.masksToBounds = false
                      upcomingMeetingImg.layer.borderColor = UIColor.black.cgColor
                      upcomingMeetingImg.layer.cornerRadius = upcomingMeetingImg.frame.height/2
                      upcomingMeetingImg.clipsToBounds = true

        completedImg.layer.borderWidth = 1
                             completedImg.layer.masksToBounds = false
                             completedImg.layer.borderColor = UIColor.black.cgColor
                             completedImg.layer.cornerRadius = completedImg.frame.height/2
                             completedImg.clipsToBounds = true

        todayImg.layer.borderWidth = 1
                             todayImg.layer.masksToBounds = false
                             todayImg.layer.borderColor = UIColor.black.cgColor
                             todayImg.layer.cornerRadius = todayImg.frame.height/2
                             todayImg.clipsToBounds = true

        meetingListTableView.layer.borderWidth = 1.0

                       meetingListTableView.layer.borderColor = UIColor.lightGray.cgColor

        self.JTCalendarCollectionView.register(UINib(nibName: "calendarBasicCell", bundle: nil), forCellWithReuseIdentifier: "calendarBasicCell")
        self.startDate =  Date().toString(dateFormat: "yyyy MM dd")
//               self.endDate = formatter.string(from: Date().getThisMonthEnd()!)
         self.JTCalendarCollectionView.scrollToDate(Date(),animateScroll: false)
               self.JTCalendarCollectionView.selectDates([ Date() ])
               setupCalendarView()
               self.JTCalendarCollectionView.ibCalendarDataSource = self
               self.JTCalendarCollectionView.ibCalendarDelegate = self

          ANLoader.showLoading()
        
        self.getEvents()
    }
    
    
    @IBAction func nextMonthButtonTapped(_ sender:UIButton){
        self.JTCalendarCollectionView.scrollToSegment(.next)
        
    }
    @IBAction func previousMonthButtonTapped(_ sender:UIButton){
        self.JTCalendarCollectionView.scrollToSegment(.previous)
    }
    
    func getEvents(){
        // Do any additional setup after loading the view.
      
       GraphManager.instance.getEvents {
                          (eventArray: [MSGraphEvent]?, error: Error?) in
                          DispatchQueue.main.async {
                              
                              guard let events = eventArray, error == nil else {
                                  // Show the error
                                  let alert = UIAlertController(title: "Error getting events",
                                                                message: error.debugDescription,
                                                                preferredStyle: .alert)
                                  
                                  alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                  self.present(alert, animated: true)
                                  return
                              }
                              
                              self.events = events
                              self.meetingListTableView.reloadData()
                            
                            ANLoader.hide()

                          }
                      }
    }
    func setupCalendarView(){
           //Setup calendar spacing
           JTCalendarCollectionView.minimumLineSpacing = 0
           JTCalendarCollectionView.minimumInteritemSpacing = 0

    }
    
    //MARK:- JTCalendarCollectionView

    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
           guard let startDate = visibleDates.monthDates.first?.date else {
               return
           }
           let month = customCalendar.dateComponents([.month], from: startDate).month!
           let monthName = DateFormatter().monthSymbols[(month-1) % 12]
           // 0 indexed array
           let year = customCalendar.component(.year, from: startDate)
           monthLabel.text = monthName + " " + String(year)
       }
    
    
       func handleCellSelected(cell: JTACDayCell?, cellState: CellState){
           guard let validCell = cell as? calendarBasicCell else { return }
           self.handleCellTextColor(cell: validCell, cellState: cellState)
           if cellState.isSelected {
               validCell.selectedView.isHidden = false
//               validCell.selectedView.backgroundColor = self.hexStringToUIColor(hex: "0F3B35", opacity: 1)
               validCell.dateLabel.textColor = .white
//               validCell.monthLabel.textColor = .white
//               validCell.dayNameLabel.textColor = .white
              
           } else {
               validCell.selectedView.isHidden = true
               
           }
       }
       
       func handleCellTextColor(cell: calendarBasicCell, cellState: CellState){

           if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = .red//self.hexStringToUIColor(hex: "0F3B35", opacity: 1)
//               cell.dayNameLabel.textColor = self.hexStringToUIColor(hex: "0F3B35", opacity: 1)
//               cell.monthLabel.textColor = self.hexStringToUIColor(hex: "8A9594", opacity: 1)
               
           } else {
               cell.dateLabel.textColor = .lightGray
//               cell.monthLabel.textColor = .lightGray
//               cell.dayNameLabel.textColor = .gray
           }
       }
    @IBAction func menuBtnClick(_ sender: Any) {
        
        showMenu()
        
    }
    
    func showMenu(){
          
     //        self.menuVc.view.frame = CGRect()
             
             UIView.animate(withDuration: 0.0, animations: {
                 
                 self.menuVc.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                 self.menuVc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                 self.addChild(self.menuVc)
                 self.view.addSubview(self.menuVc.view)
             })
             }
    
      override func viewDidAppear(_ animated: Bool) {
            
            super.viewDidAppear(animated)
                  
        }
        
    }

extension MeetingsViewController:UITableViewDelegate,UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return events?.count ?? 0

}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier:"MeetingListTVCell") as! MeetingListTVCell
           
           // Get the event that corresponds to the row
           let event = events?[indexPath.row]
    
    cell.projectNameLbl.text = event?.subject
    cell.teamLocationLbl.text = event?.organizer?.emailAddress?.name
    cell.timeLbl.text = event?.start?.dateTime
        
 
    return cell
    
   }

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   return 80
 }

}

extension MeetingsViewController: JTACMonthViewDataSource,JTACMonthViewDelegate {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let df = DateFormatter()
        df.dateFormat = "yyyy MM dd"
        
        let startDate = df.date(from: "\(String(describing: self.startDate ))")!
        let endDate = df.date(from: "\(String(describing: self.endDate ))")!
        
        let parameter = ConfigurationParameters(startDate: startDate,
                                                endDate: endDate,
                                                numberOfRows: 6,
                                                generateInDates: .forAllMonths,
                                                generateOutDates: .tillEndOfGrid,
                                                firstDayOfWeek: .sunday)
        return parameter
    }
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool{
        if cellState.dateBelongsTo == .thisMonth {
            return true
        }else{
           return false
        }
        
    }
    func calendar(_ calendar: JTACMonthView, shouldDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool{
        if cellState.dateBelongsTo == .thisMonth {
            return true
        }else{
            return false
        }
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
        handleCellSelected(cell: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarBasicCell", for: indexPath) as! calendarBasicCell
        formatter.dateFormat = "EE"
        let dayInWeek = formatter.string(from: date)
        print(dayInWeek)
        formatter.dateFormat = "MMM"
        let month = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let monthNumber = formatter.string(from: date)
        cell.dateLabel.text = cellState.text
        
//        cell.dayNameLabel.text = dayInWeek
//        cell.monthLabel.text = month
        
        let currentDate = Date()
        let calendar1 = Calendar.current
        let components = calendar1.dateComponents([.year, .month, .day], from: currentDate)
        
//        if Int(cellState.text) == components.day && Int(monthNumber) == components.month {
//            cell.currentDateView.isHidden = false
//        }else{
//            cell.currentDateView.isHidden = true
//        }
        handleCellSelected(cell: cell, cellState: cellState)
        
//        if Date() <= date {
//            cell.meetingStateImageView.layer.masksToBounds = false
//            cell.meetingStateImageView.layer.borderColor = UIColor.black.cgColor
//            cell.meetingStateImageView.layer.cornerRadius = cell.meetingStateImageView.frame.height/2
//            cell.meetingStateImageView.clipsToBounds = true
//        }else{
//            cell.meetingStateImageView.layer.masksToBounds = false
//            cell.meetingStateImageView.layer.borderColor = UIColor.red.cgColor
//            cell.meetingStateImageView.layer.cornerRadius = cell.meetingStateImageView.frame.height/2
//            cell.meetingStateImageView.backgroundColor = UIColor.black
//            cell.meetingStateImageView.clipsToBounds = true
//        }
        
        if self.events?.count ?? 0  > 0  {
            for mDate in self.events! {
//                print(mDate.start?.dateTime)
                
                
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
//                let date = dateFormatter.date(from: mDate.start?.dateTime ?? "")
////                yyyy-MM-dd'T'HH:mm:ssZZZZZ
//
//                print(date)
                
                
                let RFC3339DateFormatter = DateFormatter()
                RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
                RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ZZZZZZZ"
                RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                 
                /* 39 minutes and 57 seconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time) */
                let string = "1996-12-19T16:39:57-08:00"
                let date = RFC3339DateFormatter.date(from: string)
                print(date)
                
            }
            
        }
        
        
        
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath){
        //print(cellState.date)
        print(date)
        
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        self.calSelectedDate = "09-10-2019"//dateFormatter.string(from: date)
        
        handleCellSelected(cell: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath){
        print(cellState.dateBelongsTo)
        handleCellSelected(cell: cell, cellState: cellState)
    }
    
    
    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
    }
    
    /*  Don't delete these delegates
     func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool
     func calendar(_ calendar: JTACMonthView, shouldDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool
     func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath)
     func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath)
     func calendar(_ calendar: JTACMonthView, didHighlightDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath)
     func calendar(_ calendar: JTACMonthView, didUnhighlightDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath)
     func calendar(_ calendar: JTACMonthView, willScrollToDateSegmentWith visibleDates: DateSegmentInfo)
     func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo)
     func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView
     func calendarDidScroll(_ calendar: JTACMonthView)
     func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize?
     func sizeOfDecorationView(indexPath: IndexPath) -> CGRect
     func scrollDidEndDecelerating(for calendar: JTACMonthView)
 */
}


extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
