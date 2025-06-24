$(document).ready(function () {
  console.log("Debug:", { loginStatus, userRole });

  if (loginStatus === "success") {
    if (userRole === "customer") {
      showPopup("You are logged in as a Customer.");
    } else if (userRole === "homestay_owner") {
      showPopup("You are logged in as a Homestay Owner.");
    } else {
      showPopup("Successful Login.");
    }
  } else if (loginStatus === "fail") {
    showPopup("Incorrect email or password!");
  }

  $("#popupClose").click(function () {
    $("#popupBox").fadeOut();

    if (loginStatus === "success") {
      if (userRole === "homestay_owner") {
        window.location.replace("OwnerDashboardServlet");
      } else if (userRole === "customer") {
        window.location.replace("CustomerDashboardServlet");
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
