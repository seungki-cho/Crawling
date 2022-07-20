import SwiftSoup
import Foundation

public struct Crawling {
    public init() {
        
    }
    func crawling(_ search:String)->[[String]]{
        let urlAddr = "http://search.zum.com/search.zum?query=" + search
        guard let url = URL(string: urlAddr) else { return [[""]] }
        var html = String()
        var doc = Document("")
        do{
            html = try! String(contentsOf: url)
            doc = try SwiftSoup.parse(html)
        }catch{
            print("error")
        }
        
        let title: Elements = try! doc.select(".site_sc.section.sboundary >.type_01").select(".site_name.clear_float")
        let introduce: Elements = try! doc.select(".site_sc.section.sboundary >.type_01").select(".txt")
        let site: Elements = try! doc.select(".site_sc.section.sboundary >.type_01").select(".txt_block")
        
        var (titleString,introString,siteString) = ([String](),[String](),[String]())
        
        for i in title{ titleString.append(try! i.text().replacingOccurrences(of: "신고", with: "")) }
        for i in introduce{ introString.append(try! i.text()) }
        for i in site{ siteString.append(try! i.text())}
        
        // return 을 위한 배열 생성
        var output = [[String]]()
        
        for i in 0..<titleString.count{
            output.append([titleString[i],introString[i],siteString[i]])
        }
        return output
    }
    
}
