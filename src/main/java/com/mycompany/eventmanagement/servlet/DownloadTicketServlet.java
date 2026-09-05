package com.mycompany.eventmanagement.servlet;

import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.client.j2se.MatrixToImageWriter;

import com.mycompany.eventmanagement.dao.BookingDAO;
import com.mycompany.eventmanagement.model.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

@WebServlet("/DownloadTicketServlet")
public class DownloadTicketServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        BookingDAO dao = new BookingDAO();

        Booking booking = dao.getBookingById(bookingId);

        if (booking == null) {
            response.getWriter().println("Booking not found.");
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=Ticket_" + bookingId + ".pdf");

        try {

            Document document = new Document();

            PdfWriter.getInstance(document, response.getOutputStream());

            document.open();

            Font title = new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD);
            Font heading = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
            Font normal = new Font(Font.FontFamily.HELVETICA, 13);

            document.add(new Paragraph("EVENT MANAGEMENT SYSTEM", title));

            document.add(new Paragraph(" "));

            document.add(new Paragraph("CONFIRMED EVENT TICKET", heading));

            document.add(new Paragraph(" "));

            document.add(new Paragraph("-------------------------------------------------------------------------------------------------------------------------------"));

            document.add(new Paragraph("Booking ID : " + booking.getBookingId(), normal));
            document.add(new Paragraph("Customer Name : " + booking.getUserName(), normal));
            document.add(new Paragraph("Event Name : " + booking.getEventName(), normal));
            document.add(new Paragraph("Ticket Type : " + booking.getTicketType(), normal));
            document.add(new Paragraph("Tickets Booked : " + booking.getSeatsBooked(), normal));
            document.add(new Paragraph("Total Amount : ₹" + booking.getTotalAmount(), normal));
            document.add(new Paragraph("Status : " + booking.getStatus(), normal));
            document.add(new Paragraph("Booking Date : " + booking.getBookingDate(), normal));

            document.add(new Paragraph(" "));

            document.add(new Paragraph("-------------------------------------------------------------------------------------------------------------------------------"));

            document.add(new Paragraph("Thank you for booking with us!", normal));
            document.add(new Paragraph("Please carry this ticket while entering the event.", normal));

            document.add(new Paragraph(" "));
            document.add(new Paragraph("Scan this QR Code at the Event Entrance", heading));
            document.add(new Paragraph(" "));

            // QR Code Data
String qrData =
        "https://eventmanagementticketingsystem.onrender.com/EventManagementTicketingSystem/viewTicket.jsp?bookingId="
        + booking.getBookingId();

// Generate QR Code
BitMatrix bitMatrix = new MultiFormatWriter().encode(
        qrData,
        BarcodeFormat.QR_CODE,
        220,
        220
);

BufferedImage bufferedImage =
        MatrixToImageWriter.toBufferedImage(bitMatrix);

ByteArrayOutputStream baos = new ByteArrayOutputStream();

ImageIO.write(bufferedImage, "png", baos);

Image qrImage = Image.getInstance(baos.toByteArray());

qrImage.scaleAbsolute(180, 180);
qrImage.setAlignment(Image.ALIGN_CENTER);

document.add(qrImage);

document.add(new Paragraph(" "));
document.add(new Paragraph("-------------------------------------------------------------------------------------------------------------------------------"));
            document.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}