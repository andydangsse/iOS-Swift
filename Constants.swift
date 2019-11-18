//
//  Constants.swift
//  EmotionApp
//
//  Created by Le Thanh Tan on 12/14/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

class Constants {
    enum StoryBoard {
        static let main = UIStoryboard(name: "Main", bundle: nil)
    }
    
    enum ViewControllerIdentifier {
        static let navigationController = "MainNavigationController"
        static let home = "HomeViewController"
        static let seenByYear = "SeenFollowYearViewController"
        static let seenByName = "SeenFollowNameViewController"
        static let seenByDate = "SeenFollowDateViewController"
        static let resultPage = "ResultPageViewController"
        static let resultPageName = "ResultPageNameViewController"
        static let resultPageDateTime = "ResultDateTimeViewController"
        static let hocTuVi = "HocTuViViewController"
    }
    
    struct AdMobId {
        static let banner_id = "ca-app-pub-4490959074970584/6689690154"
        static let full_screen_id = "ca-app-pub-4490959074970584/8166423357"
    }
    
    struct Revmob {
        static let Id = "52c961d8ccac1789d7000047"
    }
    
    enum UrlIdentifier {
        static let urlForYear = "http://huyenbi.net/tu-vi-tron-doi.html"
        static let urlForName = "http://huyenbi.net/Xem-boi-Ai-cap.html"
        static let urlForTime = "http://huyenbi.net/Tu-vi-theo-gio-sinh.html"
        static let urlForDate = "http://huyenbi.net/Tu-vi-theo-ngay-sinh.html"
        static let urlForHotGame = "http://www.bestappsforphone.com/iosgameofthemonth"
        static let urlHocTuVi = "http://tuvisomenh.com/cac-buoc-luan-%C4%91oan-la-so-tu-vi-phan-1"
    }
    
    enum localize {
        static let Title_Section_Year_2 = "CUỘC SỐNG"
        static let Title_Section_Year_3 = "TÌNH DUYÊN"
        static let Title_Section_Year_4 = "GIA ĐẠO, CÔNG DANH"
        static let Title_Section_Year_5 = "TUỔI HẠP CHO LÀM ĂN"
        static let Title_Section_Year_6 = "LỰA CHỌN VỢ CHỒNG"
        static let Title_Section_Year_7 = "NHỮNG TUỔI ĐẠI KỴ"
        static let Title_Section_Year_8 = "NHỮNG NĂM KHÓ KHĂN NHẤT"
        static let Title_Section_Year_9 = "NGÀY, GIỜ XUẤT HÀNH HẠP NHẤT"
        static let Title_Section_Year_10 = "DIỄN TIẾN TỪNG NĂM"
        
        static let Title_Time_First = "BÌNH GIẢI"
    }
    
    struct Key {
        static let Param_Year = "nam"
        static let Param_Sex = "r1"
        static let Param_TuViTronDoi = "tuvitrondoi"
        
        static let Param_Hoten = "hoten"
        static let Param_XemBoiAiCap = "xemboiaicap"
        
        static let Param_Gio = "gio_xem"
        static let Param_Ngay = "ngay"
        static let Param_Thang = "thang"
        static let Param_API_Gio = "giosinh"
        static let Param_API_Nam = "namsinh"
      
        static let kDomainName = "com.lethanhtan"
      
      
        // Key for parse string
        static let kTuoi = "Tuoi"
        static let kSanhNam = "SanhNam"
        static let kMang = "Mang"
        static let kKhacSo = "KhacSo"
        static let kConNha = "ConNha"
        static let kXuong = "Xuong"
        static let kTuongTinh = "TuongTinh"
        static let kGioSinh = "Gio_Sinh"
        static let kViTriSinh = "ViTriSinh"
        static let kVanMenh = "VanMenh"
        
        static let kYear_Section_1 = "Section1"
        
        static let kYear_Content_1 = "Content1"
        static let kYear_Content_2 = "Content2"
        static let kYear_Content_3 = "Content3"
        static let kYear_Content_4 = "Content4"
        static let kYear_Content_5 = "Content5"
        static let kYear_Content_6 = "Content6"
        static let kYear_Content_7 = "Content7"
        static let kYear_Content_8 = "Content8"
        static let kYear_Content_9 = "Content9"
        static let kYear_Content_10 = "Content10"
      
    }
  
  
    
    struct XPath {
        static let Path_Year_Type_1 = "//table[@id='calendar']/tr/td/p"
        static let Path_Year_Type_2 = "//table[@id='calendar']/tr/td/ul/li/span"
        
        static let Path_Name_Type_1 = "//table[@id='calendar']/tr/td/center"
        static let Path_Name_Type_2 = "//table[@id='calendar']/tr/td/p"
        
        static let Path_Time_Type_1 = "//table[@id='calendar']/tr/td"
        static let Path_Time_Type_2 = "//table[@id='calendar']/tr/td/p"
        static let Path_Time_Type_3 = "//table[@id='calendar']/tr/td/table/tbody/tr"
        
        static let Path_Date_Type_1 = "//table[@id='calendar']/tr/td/center/b/font"
        static let Path_Date_Type_2 = "//table[@id='calendar']/tr/td/b/font"
        static let Path_Date_Type_3 = "//table[@id='calendar']/tr/td/p"
        
    }
    
    
    struct KeyDefault {
        static let LanguageCode = "LanguageCode"
    }
    
    struct GoogleAds {
        static let ID = "ca-app-pub-4490959074970584/9156138958"
        static let BannerID = "ca-app-pub-4490959074970584/2325275752"
    }
    
    static let platform = "iOS"
    static let Male_Sex = 0
    static let Female_Sex = 1
    
    static let Date_TinhCach = "TÍNH CÁCH"
    static let Date_QuanHe = "QUAN HỆ"
    static let Date_GiaDinh = "GIA ĐÌNH"
    static let Date_NgheNghiep = "NGHỀ NGHIỆP"
    
}
