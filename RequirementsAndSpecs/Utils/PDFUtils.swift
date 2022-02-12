//
//  PDFUtils.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/12/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import SwiftUI

class PDFUtils
{
    //  Takes the existing view and converts it to a PDF file
    static func exportToPDF()
    {
        let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("SwiftUI.pdf")
        let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        // View to render on PDF
        let myUIHostingController = UIHostingController(rootView: RequirementListView())
        myUIHostingController.view.frame = CGRect(origin: .zero, size: pageSize)

        // Get the view behind all other views
        guard let rootVC = UIApplication().keyWindow?.rootViewController
        else
        {
            Log.error("Could not find root ViewController.")
            return
        }
        
        rootVC.addChild(myUIHostingController)
        
        // at: 0 -> draws behind all other views
        // at: UIApplication.shared.windows.count -> draw in front
        rootVC.view.insertSubview(myUIHostingController.view, at: 0)

        // Render the PDF
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
        
        DispatchQueue.main.async
        {
            do
            {
                try pdfRenderer.writePDF(to: outputFileURL, withActions: { context in
                    context.beginPage()
                    myUIHostingController.view.layer.render(in: context.cgContext)
                })
                Log.info("wrote file to: \(outputFileURL.path)")
            }
            catch
            {
                Log.error("Could not create PDF file: \(error.localizedDescription)")
            }

            // Remove rendered view
            myUIHostingController.removeFromParent()
            myUIHostingController.view.removeFromSuperview()
        }
    }
}
