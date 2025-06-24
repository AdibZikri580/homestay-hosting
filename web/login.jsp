<%@ page contentType="text/html;charset=UTF-8" %>
<%
  response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader("Expires", 0);

  String login = (String) request.getAttribute("login");
  String role = (String) request.getAttribute("role");
%>

<!DOCTYPE html>
<html>
    <head>
      <title>HomestayFinder - Login</title>
      <link rel="stylesheet" href="css/login.css">
      <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
      <script>
        const loginStatus = "<%= login != null ? login : "" %>";
        const userRole = "<%= role != null ? role : "" %>";
      </script>
      <script src="js/login.js"></script>
    </head>
    <body>

      <!-- Panel Login -->
      <div class="panel">
        <h2>Welcome to<br>HomestayFinder</h2>
        <p class="tagline">The best homestay booking platform in Malaysia</p>

        <form id="loginForm" action="LoginServlet" method="post">
          <input type="email" name="email" placeholder="E‑mel" required>
          <input type="password" name="password" placeholder="Password" required>

          <div class="forgot-line">
            <a href="register.jsp">Register Here</a>
            <a href="forgot.jsp">Forget Password?</a>
          </div>

          <button type="submit" class="btn-main">Login</button>
        </form>
      </div>

      <!-- Popup -->
      <div id="popupBox" class="popup" style="display: none;">
        <div class="popup-content">
          <p id="popupMessage"></p>
          <button id="popupClose">Close</button>
        </div>
      </div>

    </body>
</html>
