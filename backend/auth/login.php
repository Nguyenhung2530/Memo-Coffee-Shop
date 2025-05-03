<?php
session_start();
require_once '../includes/config.php';

// Cấu hình CORS
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json; charset=utf-8');

// Xử lý OPTIONS request (CORS preflight)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Chỉ chấp nhận POST request
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    exit;
}

$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

if (empty($email) || empty($password)) {
    echo json_encode(['success' => false, 'message' => 'Vui lòng nhập đầy đủ thông tin']);
    exit;
}

try {
    // Kiểm tra kết nối database
    if (!$pdo) {
        throw new PDOException('Không thể kết nối đến database');
    }

    $stmt = $pdo->prepare('SELECT UserID, FullName, PasswordHash, Role FROM user_account WHERE Email = ? AND Status = "Active"');
    if (!$stmt) {
        throw new PDOException('Lỗi khi chuẩn bị câu lệnh SQL');
    }

    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && $user['PasswordHash'] === $password) {
        $role = strtolower(trim($user['Role']));
        if ($role === 'admin' || $role === 'quản lý' || $role === 'manager') {
            $_SESSION['user_id'] = $user['UserID'];
            $_SESSION['username'] = $user['FullName'];
            $_SESSION['role'] = $user['Role'];
            $_SESSION['logged_in'] = true;
            echo json_encode([
                'success' => true,
                'message' => 'Đăng nhập thành công',
                'redirect' => '/Coffe_Management/backend/dashboard.html',
                'user' => [
                    'username' => $user['FullName'],
                    'role' => $user['Role']
                ]
            ]);
        } else if ($role === 'khách hàng' || $role === 'customer') {
            $_SESSION['user_id'] = $user['UserID'];
            $_SESSION['username'] = $user['FullName'];
            $_SESSION['role'] = $user['Role'];
            $_SESSION['logged_in'] = true;
            echo json_encode([
                'success' => true,
                'message' => 'Đăng nhập thành công',
                'redirect' => '/Coffe_Management/frontend/assets/websites.html',
                'user' => [
                    'username' => $user['FullName'],
                    'role' => $user['Role']
                ]
            ]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Bạn không có quyền truy cập']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Email hoặc mật khẩu không đúng']);
    }
} catch (PDOException $e) {
    error_log('Login error: ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Lỗi server: ' . $e->getMessage()]);
}
?> 