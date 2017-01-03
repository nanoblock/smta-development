  function openNav() {
    if ('<%= @browser %>' == 'phone') {
      $("#mySidenav").css('width', '100%');  
    } else {
      $("#mySidenav").css('width', '470px');
    }
  }

  function closeNav() {
    $("#mySidenav").css('width', 0);
  }