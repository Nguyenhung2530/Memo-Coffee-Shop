<?php
session_start();
session_destroy(); // Xóa tất cả session
header("Location: login.html"); // Chuyển hướng về trang đăng nhập
exit;
?>
