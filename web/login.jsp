<%@ page contentType="text/html;charset=UTF-8" %>

<%
  response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
%>

<!DOCTYPE html>
<html>
    <head>
      <title>HomestayFinder - Login</title>
      <link rel="stylesheet" href="css/login.css">
      <script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
      <script src="js/login.js"></script>
      
      <%
        Boolean loginSuccess = (Boolean) request.getAttribute("loginSuccess");
        Boolean loginFail = (Boolean) request.getAttribute("loginFail");
        String userRole = (String) request.getAttribute("userRole");

        if (loginSuccess == null) loginSuccess = false;
        if (loginFail == null) loginFail = false;
      %>

      <script>
        const loginSuccess = <%= loginSuccess %>;
        const loginFail = <%= loginFail %>;
        const userRole = "<%= userRole != null ? userRole : "" %>";
      </script>

    </head>
    <body>

        <!--Panel Login-->
        <div class="panel">
          <h2>Welcome to<br>HomestayFinder</h2>
          <p class="tagline">The best homestay booking platform in Malaysia</p>

          <form id="loginForm" action="LoginServlet" method="post">
              <input type="email"   name="email"    placeholder="E‑mel"    required>
              <input type="password" name="password" placeholder="Password" required>

              <div class="forgot-line">
                <a href="register.jsp">Register Here</a>
                <a href="forgot.jsp">Forget Password?</a>
              </div>

              <button type="submit" class="btn-main">Login</button>
          </form>
        </div>

        <!-- Popup untuk mesej -->
        <div id="popupBox" class="popup">
          <div class="popup-content">
            <p id="popupMessage"></p>
            <button id="popupClose">Close</button>
          </div>
        </div>

    </body>
</html>
