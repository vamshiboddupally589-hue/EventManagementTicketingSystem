<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.mycompany.eventmanagement.dao.BookingDAO"%>
<%@page import="com.mycompany.eventmanagement.model.Booking"%>

<%
BookingDAO dao = new BookingDAO();
List<Booking> bookings = dao.getAllBookings();

int totalBookings = bookings.size();

int confirmed = 0;
int cancelled = 0;

double totalRevenue = 0;

for (Booking booking : bookings) {

    totalRevenue += booking.getTotalAmount();

    if ("CONFIRMED".equalsIgnoreCase(booking.getStatus())) {
        confirmed++;
    }

    if ("CANCELLED".equalsIgnoreCase(booking.getStatus())) {
        cancelled++;
    }
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>All Bookings</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
}

body{
    background:#f4f6f9;
}

.container{
    width:92%;
    margin:40px auto;
}

.card{
    background:white;
    padding:30px;
    border-radius:12px;
    box-shadow:0 5px 15px rgba(0,0,0,.15);
}

.hero h1{
    color:#000 !important;
    font-size:55px;
    font-weight:900;
    text-shadow:none;
}
table{
    width:100%;
    border-collapse:collapse;
}

table th{
    background:#0d6efd;
    color:white;
    padding:15px;
}

table td{
    padding:14px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

table tr:hover{
    background:#f8fbff;
}

.status-confirmed{
    background:#28a745;
    color:white;
    padding:6px 15px;
    border-radius:20px;
    font-size:13px;
    font-weight:bold;
}

.status-cancelled{
    background:#dc3545;
    color:white;
    padding:6px 15px;
    border-radius:20px;
    font-size:13px;
    font-weight:bold;
}
.back-btn{
    display:inline-block;
    margin-top:25px;
    background:#0d6efd;
    color:white;
    text-decoration:none;
    padding:12px 22px;
    border-radius:8px;
    font-weight:bold;
}

.back-btn:hover{
    background:#0b5ed7;
}

.header{
    background:linear-gradient(135deg,#0d6efd,#3b82f6);
    color:white;
    text-align:center;
    padding:30px;
    border-bottom-left-radius:15px;
    border-bottom-right-radius:15px;
}

.header h1{
    margin:0;
    font-size:34px;
}

.header p{
    margin-top:8px;
    font-size:16px;
    opacity:.9;
}
/* ================= Dashboard Cards ================= */

.dashboard-cards{
    display:flex;
    gap:20px;
    margin:25px 0;
    flex-wrap:wrap;
}

.dashboard-card{
    flex:1;
    min-width:220px;
    background:white;
    border-radius:12px;
    padding:25px;
    text-align:center;
    box-shadow:0 5px 15px rgba(0,0,0,.15);
    transition:.3s;
}

.dashboard-card:hover{
    transform:translateY(-5px);
}

.dashboard-card h3{
    color:#666;
    margin-bottom:12px;
    font-size:18px;
}

.dashboard-card h2{
    color:#0d6efd;
    font-size:34px;
    margin:0;
}
/* Search Box */

.search-container{
    margin:20px 0;
}

.search-container input{
    width:100%;
    padding:12px 15px;
    border:1px solid #ccc;
    border-radius:8px;
    font-size:16px;
    outline:none;
}

.search-container input:focus{
    border-color:#0d6efd;
    box-shadow:0 0 5px rgba(13,110,253,.3);
}
</style>

</head>
<body>

<div class="header">
     <h1>Booking Management</h1>
    <p>View and manage all customer bookings</p>
</div>

<div class="container">

    <div class="card">

        <h1>All Bookings</h1>

        <div class="dashboard-cards">

            <div class="dashboard-card">
                <h3>Total Bookings</h3>
                <h2><%= totalBookings %></h2>
            </div>

            <div class="dashboard-card">
                <h3>Total Revenue</h3>
                <h2>₹ <%= totalRevenue %></h2>
            </div>

            <div class="dashboard-card">
                <h3>Confirmed</h3>
                <h2><%= confirmed %></h2>
            </div>

            <div class="dashboard-card">
                <h3>Cancelled</h3>
                <h2><%= cancelled %></h2>
            </div>

        </div>

        <div class="search-container">

            <input
                type="text"
                id="searchInput"
                placeholder="🔍 Search by Customer or Event..."
                onkeyup="searchTable()">

        </div>

        <table>

            <tr>
                <th>Booking ID</th>
                <th>Customer</th>
                <th>Event Name</th>
                <th>Tickets</th>
                <th>Total Amount</th>
                <th>Status</th>
                <th>Booking Date</th>
            </tr>

            <%
            if(bookings.size() == 0){
            %>

            <tr>
                <td colspan="7" style="padding:25px;font-size:18px;color:gray;">
                    No bookings found.
                </td>
            </tr>

            <%
            }else{

                for(Booking booking : bookings){
            %>

            <tr>

                <td><%= booking.getBookingId() %></td>

                <td><%= booking.getUserName() %></td>

                <td><%= booking.getEventName() %></td>

                <td><%= booking.getSeatsBooked() %></td>

                <td>₹ <%= booking.getTotalAmount() %></td>

                <td>

                    <%
                    if("CONFIRMED".equalsIgnoreCase(booking.getStatus())){
                    %>

                    <span class="status-confirmed">
                        CONFIRMED
                    </span>

                    <%
                    }else{
                    %>

                    <span class="status-cancelled">
                        CANCELLED
                    </span>

                    <%
                    }
                    %>

                </td>

                <td><%= booking.getBookingDate() %></td>

            </tr>

            <%
                }
            }
            %>

        </table>

        <br>

        <a href="adminDashboard.jsp" class="back-btn">
            Back
        </a>

    </div> <!-- card -->

</div> <!-- container -->

<script>

function searchTable() {

    var input = document.getElementById("searchInput");
    var filter = input.value.toUpperCase();

    var table = document.querySelector("table");
    var tr = table.getElementsByTagName("tr");

    for (var i = 1; i < tr.length; i++) {

        var tdUser = tr[i].getElementsByTagName("td")[1];
        var tdEvent = tr[i].getElementsByTagName("td")[2];

        if (tdUser && tdEvent) {

            var user = tdUser.textContent || tdUser.innerText;
            var event = tdEvent.textContent || tdEvent.innerText;

            if (
                user.toUpperCase().indexOf(filter) > -1 ||
                event.toUpperCase().indexOf(filter) > -1
            ) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }

        }

    }

}

</script>

</body>

</html>