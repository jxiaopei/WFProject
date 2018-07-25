//
//  WFWeatherImageManager.swift
//  WFProject
//
//  Created by hello on 2018/7/20.
//  Copyright © 2018年 WF. All rights reserved.
//

/*
 weatherId
 http://www.openweathermap.org/weather-conditions
 
 Thunderstorm ID Meaning Icon
 200    thunderstorm with light rain    [[file:11d.png]]
 201    thunderstorm with rain            [[file:11d.png]]
 202    thunderstorm with heavy rain    [[file:11d.png]]
 210    light thunderstorm                [[file:11d.png]]
 211    thunderstorm                    [[file:11d.png]]
 212    heavy thunderstorm                [[file:11d.png]]
 221    ragged thunderstorm                [[file:11d.png]]
 230    thunderstorm with light drizzle    [[file:11d.png]]
 231    thunderstorm with drizzle        [[file:11d.png]]
 232    thunderstorm with heavy drizzle    [[file:11d.png]]
 
 Drizzle ID    Meaning    Icon
 300    light intensity drizzle            [[file:09d.png]]
 301    drizzle                            [[file:09d.png]]
 302    heavy intensity drizzle            [[file:09d.png]]
 310    light intensity drizzle rain    [[file:09d.png]]
 311    drizzle rain                    [[file:09d.png]]
 312    heavy intensity drizzle rain    [[file:09d.png]]
 313    shower rain and drizzle            [[file:09d.png]]
 314    heavy shower rain and drizzle    [[file:09d.png]]
 321    shower drizzle    [[file:09d.png]]
 
 Rain ID Meaning Icon
 500    light rain    [[file:10d.png]]
 501    moderate rain    [[file:10d.png]]
 502    heavy intensity rain    [[file:10d.png]]
 503    very heavy rain    [[file:10d.png]]
 504    extreme rain    [[file:10d.png]]
 511    freezing rain    [[file:13d.png]]
 520    light intensity shower rain    [[file:09d.png]]
 521    shower rain    [[file:09d.png]]
 522    heavy intensity shower rain    [[file:09d.png]]
 531    ragged shower rain    [[file:09d.png]]
 Snow
 ID    Meaning    Icon
 600    light snow    [[file:13d.png]]
 601    snow    [[file:13d.png]]
 602    heavy snow    [[file:13d.png]]
 611    sleet    [[file:13d.png]]
 612    shower sleet    [[file:13d.png]]
 615    light rain and snow    [[file:13d.png]]
 616    rain and snow    [[file:13d.png]]
 620    light shower snow    [[file:13d.png]]
 621    shower snow    [[file:13d.png]]
 622    heavy shower snow    [[file:13d.png]]
 Atmosphere
 ID    Meaning    Icon
 701    mist    [[file:50d.png]]  薄雾
 711    smoke    [[file:50d.png]]  烟雾
 721    haze    [[file:50d.png]]  迷雾
 731    sand, dust whirls    [[file:50d.png]]   尘卷风
 741    fog    [[file:50d.png]]    雾
 751    sand    [[file:50d.png]]   沙暴
 761    dust    [[file:50d.png]]   灰尘
 762    volcanic ash    [[file:50d.png]]  火山灰
 771    squalls    [[file:50d.png]]  暴风
 781    tornado    [[file:50d.png]]  龙卷风
 Clouds
 ID    Meaning    Icon
 800    clear sky    [[file:01d.png]] [[file:01n.png]]
 801    few clouds    [[file:02d.png]] [[file:02n.png]]
 802    scattered clouds    [[file:03d.png]] [[file:03d.png]]
 803    broken clouds    [[file:04d.png]] [[file:03d.png]]
 804    overcast clouds    [[file:04d.png]] [[file:04d.png]]
 Extreme
 ID    Meaning
 900    tornado  //龙卷风
 901    tropical storm  //热带风暴
 902    hurricane  //飓风
 903    cold  //寒流
 904    hot   //热流
 905    windy  //大风
 906    hail  //冰雹
 Additional
 ID    Meaning
 951    calm
 952    light breeze
 953    gentle breeze
 954    moderate breeze
 955    fresh breeze
 956    strong breeze
 957    high wind, near gale
 958    gale  暴风
 959    severe gale
 960    storm   //风暴
 961    violent storm  强风暴
 962    hurricane
 */

import Foundation

class WFWeatherImageManager: NSObject {
    
    class func getWeatherCellBackgroundImage(id: Int) -> String{
        
        var imageName : String = ""
        
        switch id {
            
        case 200,210,211,212,221,201,202,230,231,232:
            imageName = "cell_back_thunder"
            break
            
        // Drizzle
        case 300,301,302,311,312,313,314,321:
            imageName = "cell_back_overcast"
            break
            
        // Rain
        case 500,501,502,503,504,511,520,521,522,531:
            imageName = "cell_back_shower"
            break
            
        // Snow
        case 600,601,602:
            imageName = "cell_back_snow"
            break
            
        // Snow
        case 611,612,615,616,620,621,622:
            imageName = "cell_back_sleet"
            break
           /*
            701    mist    [[file:50d.png]]  薄雾
            711    smoke    [[file:50d.png]]  烟雾
            721    haze    [[file:50d.png]]  迷雾
            731    sand, dust whirls    [[file:50d.png]]   尘卷风
            741    fog    [[file:50d.png]]    雾
            751    sand    [[file:50d.png]]   沙暴
            761    dust    [[file:50d.png]]   灰尘
            762    volcanic ash    [[file:50d.png]]  火山灰
            771    squalls    [[file:50d.png]]  暴风
            781    tornado    [[file:50d.png]]  龙卷风
 */
        // Atmosphere
        case 701,711,721,731,741,751,761,762,771,781:
            imageName = "cell_back_haze"
            break
            
        // Clouds
        case 800:
            imageName = "cell_back_sunny"
            break
            
        case 801,802,803,804:
            imageName = "cell_back_cloudy"
            break
            
        case 900,901,902:
            imageName = "cell_back_thunder"
            break
            
        case 903:
            imageName = "cell_back_snow"
            break
            
        case 904:
            imageName = "cell_back_haze"
            break
            
        case 905:
            imageName = "cell_back_snow"
            break
            
        case 906:
            imageName = "cell_back_snow"
            break
            
        case 951:
            imageName = "cell_back_sunny"
            break
            
        case 952,953,954,955,956,957:
            imageName = "cell_back_cloudy"
            break
            
        case 958,959,960,961,962:
            imageName = "cell_back_thunder"
            break
  
        default:
            // 未知的情况
            imageName = "cell_back_unknow"
            break
        }
        return imageName
    }
    
    class func getWeatherIcon(id: Int,icon : String) -> String{
        var imageName : String = ""
        
        switch id {
        case 200,210,211,212,221,201,202,230,231,232:
            imageName = "thunder"
            break
            
        // Drizzle
        case 300,301,302,311,312,313,314,321:
            imageName = "drizzle"
            break
            
        // Rain
        case 500:
            imageName = "light rain"
            break
        case 501:
            imageName = "moderate rain"
            break
        case 502,503,504,511:
            imageName = "heavy rain"
            break
        case 520,521,522,531:
            imageName = "shower rain"
            break
            
        // Snow
        case 600:
            imageName = "light snow"
            break
        case 601:
            imageName = "snow"
            break
        case 602:
            imageName = "heavy snow"
            break
        // sleet
        case 611,612,615,616,620,621,622:
            imageName = "sleet"
            break
            
            /*
             701    mist    [[file:50d.png]]  薄雾
             711    smoke    [[file:50d.png]]  烟雾
             721    haze    [[file:50d.png]]  迷雾
             731    sand, dust whirls    [[file:50d.png]]   尘卷风
             741    fog    [[file:50d.png]]    雾
             751    sand    [[file:50d.png]]   沙暴
             761    dust    [[file:50d.png]]   灰尘
             762    volcanic ash    [[file:50d.png]]  火山灰
             771    squalls    [[file:50d.png]]  暴风
             781    tornado    [[file:50d.png]]  龙卷风
             */
        // Atmosphere
        case 701,711,721,731,741:
            imageName = "haze"
            break
        case 751,761,762,771,781 :
            imageName = "wind"
            break
            
        // Clouds
        case 800:
            if(icon.contains("d")){
                imageName = "sunny"
            }else{
                imageName = "sunny-night"
            }
            break
            
        case 801,802:
            if(icon.contains("d")){
                imageName = "clouds"
            }else{
                imageName = "clouds-night"
            }
            break
        case 803,804:
            imageName = "overcast"
            break
            /*
             900    tornado  //龙卷风
             901    tropical storm  //热带风暴
             902    hurricane  //飓风
             903    cold  //寒流
             904    hot   //热流
             905    windy  //大风
             906    hail  //冰雹
             Additional
             ID    Meaning
             951    calm
             952    light breeze
             953    gentle breeze
             954    moderate breeze
             955    fresh breeze
             956    strong breeze
             957    high wind, near gale
             958    gale  暴风
             959    severe gale
             960    storm   //风暴
             961    violent storm  强风暴
             962    hurricane
 */
        case 900,901,902:
            imageName = "wind"
            break
            
        case 903:
            imageName = "snow"
            break
            
        case 904:
            imageName = "haze"
            break
            
        case 905:
            imageName = "wind"
            break
            
        case 906:
            imageName = "hail"
            break
            
        case 951:
            imageName = "sunny"
            break
            
        case 952,953,954,955,956,957:
            imageName = "wind"
            break
            
        case 958,959,960,961,962:
            imageName = "wind"
            break
            
        default:
            // 未知的情况
            imageName = "unknow"
            break
        }
        return imageName
    
    }
    
}
