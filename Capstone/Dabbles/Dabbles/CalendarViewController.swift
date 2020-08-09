////
////  MyListViewController.swift
////  Dabbles
////
////  Created by cynber on 7/26/20.
////  Copyright © 2020 cyndichin. All rights reserved.
////
//
//import UIKit
//import FSCalendar
//
//class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
//    
//    fileprivate weak var calendar: FSCalendar!
//    fileprivate lazy var dateFormatter1: DateFormatter = {
//           let formatter = DateFormatter()
//           formatter.dateFormat = "yyyy/MM/dd"
//           return formatter
//       }()
//    
//     let dates = ["2020/07/21", "2020/07/22"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        
//        let calendar = FSCalendar(frame: CGRect(x: 10, y: 50, width: self.view.bounds.size.width - 20, height: 300))
//        calendar.dataSource = self
//        calendar.delegate = self
//        view.addSubview(calendar)
//        self.calendar = calendar
//        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "Cell")
//        calendar.cornerRadius = 20.0
//        calendar.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        calendar.layer.borderWidth = 1.0
//        calendar.backgroundColor = .white
//        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0
//        self.calendar.appearance.borderDefaultColor = #colorLiteral(red: 0.5791672864, green: 0.761366692, blue: 0.8611778617, alpha: 1)
//        createProgressBar()
//        
//    }
//
//    func createProgressBar() {
//        let progressView = UIProgressView(progressViewStyle: .bar)
//        progressView.center = view.center
//        progressView.setProgress(0.5, animated: true)
//        progressView.trackTintColor = UIColor.lightGray
//        progressView.tintColor = UIColor.blue
//        progressView.clipsToBounds = true
//        progressView.transform = progressView.transform.scaledBy(x: 1, y: 7)
//        progressView.layer.cornerRadius = 15.0
//        let maskLayerPath = UIBezierPath(roundedRect: progressView.bounds, cornerRadius: 4.0)
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = progressView.bounds
//        maskLayer.path = maskLayerPath.cgPath
//        progressView.layer.mask = maskLayer
//        calendar.addSubview(progressView)
//    }
//    
////
////    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
////        let key = self.dateFormatter1.string(from: date)
////        if self.datesWithMultipleEvents.contains(key) {
////            return [UIColor.magenta, appearance.eventDefaultColor, UIColor.black]
////        }
////        return nil
////    }
////
////    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
////        let key = self.dateFormatter1.string(from: date)
////        if let color = self.fillDefaultColors[key] {
////            return color
////        }
////        return appearance.selectionColor
////    }
//    
//    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
//        let key = self.dateFormatter1.string(from: date)
//        if dates.contains(key) {
//            return #colorLiteral(red: 0.5791672864, green: 0.761366692, blue: 0.8611778617, alpha: 1)
//        }
//        return nil
//    }
//    
////    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
//////           let key = self.dateFormatter1.string(from: date)
//////           if dates.contains(key) {
//////                return #colorLiteral(red: 0.5791672864, green: 0.761366692, blue: 0.8611778617, alpha: 1)
//////            }
//////           return appearance.borderDefaultColor
////       }
//    
//    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//        print(calendar.currentPage.monthAsString())
//    }
//    
////    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
////        return 0.3
////    }
////    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
////        let key = self.dateFormatter1.string(from: date)
////        if let index = dates.firstIndex(of: key) {
////            return "Day \(index + 1)"
////        }
////        return nil
////    }
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
