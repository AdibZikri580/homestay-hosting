$(document).ready(function () {

  console.log("Debug:", { loginSuccess, loginFail, userRole });

  // Jika login gagal
  if (loginFail) {
    showPopup("Incorrect email or password!");
  }

  // Jika login berjaya
  if (loginSuccess) {
    if (userRole === "customer") {
      showPopup("You are logged in as a Customer.");
    } else if (userRole === "homestay_owner") {
      showPopup("You are logged in as a Homestay Owner.");
    } else {
      showPopup("Successful Login.");
    }

    sessionStorage.setItem("user_role", userRole);
  }

  // Bila tutup popup, redirect ikut user role
  $("#popupClose").click(function () {
    $("#popupBox").fadeOut();

    if (loginSuccess) {
      const role = sessionStorage.getItem("user_role");
      if (role === "customer") {
        window.location.replace("CustomerDashboardServlet");
      } else if (role === "homestay_owner") {
        window.location.replace("OwnerDashboardServlet");
      } else {
        window.location.replace("homepage.jsp");
      }
    }
  });

  function showPopup(msg) {
    $("#popupMessage").text(msg);
    $("#popupBox").fadeIn();
  }
});
