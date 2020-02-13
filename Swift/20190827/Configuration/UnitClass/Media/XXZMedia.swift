//
//  XXZMedia.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/8/1.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

public let isVisitCamera = XXZMedia.isVisitCamera()
public let isVisitPhoto = XXZMedia.isVisitPhoto()
public let isVisitVideo = XXZMedia.isVisitVideo()
public let isVisitAudio = XXZMedia.isVisitAudio()
public let isVisitLocation = XXZMedia.isVisitLocation()

private class XXZMedia: NSObject {
    private override init() {}
    
    //MARK: ------ Zachary - media ------
    static func isVisitCamera() -> Bool { //是否能访问相机
        let media = AVMediaType.video //或AVMediaTypeAudio
        let status = AVCaptureDevice.authorizationStatus(for: media)
        
        var flag = false
        if status == .authorized { //允许访问
            flag = true
        }
        
        return flag
    }
    
    static func isVisitPhoto() -> Bool { //是否能访问相册
        let status = PHPhotoLibrary.authorizationStatus() //iOS 8.0 以上
        
        var flag = false
        if status == .authorized { //允许访问
            flag = true
        }
        
        return flag
    }
    
    static func isVisitVideo() -> Bool { //是否能访问摄像头
        let media = AVMediaType.video
        let status = AVCaptureDevice.authorizationStatus(for: media)
        
        var flag = false
        if status == .authorized { //允许访问
            flag = true
        }
        
        return flag
    }
    
    static func isVisitAudio() -> Bool { //是否能访问麦克风
        let media = AVMediaType.audio
        let status = AVCaptureDevice.authorizationStatus(for: media)
        
        var flag = false
        if status == .authorized { //允许访问
            flag = true
        }
        
        return flag
    }
    
    //MARK: ------ Zachary - location ------
    static func isVisitLocation() -> Bool { //是否能访问位置
        var flag = false
        if CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .notDetermined) {
            flag = true
        }
        else if CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .denied) {
            flag = false
        }
        
        return flag
    }
}
