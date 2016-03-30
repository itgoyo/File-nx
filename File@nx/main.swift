//
//  main.swift
//  File@nx
//
//  Created by juliano on 3/29/16.
//  Copyright © 2016 juliano. All rights reserved.
//

import Foundation

func resizeFile( originFile : String,fileSuffix : String, size : Float)  {
    let range = originFile.rangeOfString(".png")
    guard range != nil && (range?.startIndex != range?.endIndex) else
    {
        return
    }
    var fileName2 = String.init(originFile)
    fileName2.insertContentsOf(fileSuffix.characters, at: (range?.startIndex)!)
    print("fileName****:%@",fileName2)
    
    
    let cpFileCmd = "cp \(originFile) \(fileName2)"
    print(cpFileCmd)
    system(cpFileCmd)
    
    let sizp = "sips -Z \(size) \(fileName2)"
    system(sizp)
    print(sizp)
    
}

let arguments = Process.arguments
if arguments.count > 2
{
    print("hello")
    let  dirPath = arguments[1]
    //Assume the fileSize is the minimun piex width size of the files
    let fileSize : Float! = Float (arguments[2])
    print("hello:\(fileSize)" + dirPath)
    let fmg = NSFileManager.defaultManager()
    var childArray:Array = [String]();
    do
    {
        childArray = try fmg.contentsOfDirectoryAtPath(dirPath)
    }catch
    {
        print("Error occurs when listing files in dir :\(dirPath)")
        exit(0)
    }
    
    
    if(childArray.count > 0)
    {
        print("cNumber files at \(dirPath):\(childArray.count)")
        let dfmt = NSDateFormatter.init()
        dfmt.dateFormat = "yyyyMMdd_HH:mm:ss"
        let now = dfmt.stringFromDate(NSDate())
        let destFilePath = dirPath + "/" + "\(now)_Files"
        system("mkdir \(destFilePath)")
        
        for i in 0..<childArray.count
        {
            let originFilePath = dirPath + "/" + childArray[i]
            if originFilePath.containsString("@2x") || originFilePath.containsString("@3x")
            {
                
            }
            else
            {
                //cp file to destination path
                let destResizeFilePath = destFilePath + "/" + childArray[i]
                system("cp \(originFilePath) \(destResizeFilePath)")
                
                //@2x.png
                resizeFile(destResizeFilePath, fileSuffix: "@2x", size: fileSize * 2);
                //@3x.png
                resizeFile(destResizeFilePath, fileSuffix: "@3x", size: fileSize * 3);
                //.png
                resizeFile(destResizeFilePath, fileSuffix: "", size: fileSize);
            }
            
        }
        
    }else
    {
        print("catches no files at \(dirPath)!pls check it.")
    }
}

