<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Homestay" %>

<%
    List<Homestay> randomList = (List<Homestay>) request.getAttribute("randomHomestays");
%>

<% for (Homestay h : randomList) { %>
    <div class="homestay-card">
        <img src="<%= (h.getImageId() != 0) ? "FileServeServlet?id=" + h.getImageId() : "img/placeholder.png" %>" alt="Gambar Homestay">
        <h4><%= h.getName() %></h4>
        <p>RM<%= String.format("%.2f", h.getPricePerNight()) %> / night — <%= h.getCity() %>, <%= h.getState() %></p>
    </div>
<% } %>
