<?php
require_once '../../includes/config.php';

header('Content-Type: application/json');

try {
    // Xử lý thêm khách hàng mới
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (empty($_POST['fullname']) || empty($_POST['phone'])) {
            throw new Exception('Vui lòng điền đầy đủ thông tin bắt buộc');
        }

        $fullname = $_POST['fullname'];
        $phone = $_POST['phone'];
        $email = $_POST['email'] ?? null;
        $gender = $_POST['gender'] ?? 'Khác';
        $address = $_POST['address'] ?? null;
        $notes = $_POST['notes'] ?? null;
        $points = isset($_POST['points']) ? intval($_POST['points']) : 0;
        $totalSpent = isset($_POST['totalSpent']) ? floatval($_POST['totalSpent']) : 0;
        
        $stmt = $pdo->prepare("INSERT INTO customer (FullName, Phone, Email, Gender, Address, Notes, Points, TotalSpent) 
                              VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([$fullname, $phone, $email, $gender, $address, $notes, $points, $totalSpent]);
        
        echo json_encode(['success' => true, 'message' => 'Thêm khách hàng thành công']);
        exit;
    }

    // Lấy danh sách khách hàng
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        $stmt = $pdo->query("SELECT CustomerID, FullName, Phone, Email, Gender, Address, 
                            Points, TotalSpent, LastVisit, Notes 
                            FROM customer ORDER BY CustomerID ASC");
        $customers = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode(['success' => true, 'data' => $customers]);
        exit;
    }

    // Lấy 1 khách hàng theo id
    if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['id'])) {
        $id = $_GET['id'];
        $stmt = $pdo->prepare("SELECT CustomerID, FullName, Phone, Email, Gender, Address, Notes FROM customer WHERE CustomerID = ?");
        $stmt->execute([$id]);
        $cus = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($cus) {
            echo json_encode(['success' => true, 'data' => $cus]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Không tìm thấy khách hàng']);
        }
        exit;
    }

    // Xóa khách hàng
    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        if (empty($_GET['id'])) {
            throw new Exception('ID không được để trống');
        }
        
        $id = $_GET['id'];
        $stmt = $pdo->prepare("DELETE FROM customer WHERE CustomerID = ?");
        $stmt->execute([$id]);
        
        echo json_encode(['success' => true, 'message' => 'Xóa khách hàng thành công']);
        exit;
    }

    // Cập nhật khách hàng
    if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
        parse_str(file_get_contents("php://input"), $put_vars);
        if (empty($put_vars['id'])) {
            throw new Exception('ID không được để trống');
        }
        
        $id = $put_vars['id'];
        $fullname = $put_vars['fullname'] ?? '';
        $phone = $put_vars['phone'] ?? '';
        $email = $put_vars['email'] ?? '';
        $gender = $put_vars['gender'] ?? '';
        $address = $put_vars['address'] ?? '';
        $notes = $put_vars['notes'] ?? '';
        $points = isset($put_vars['points']) ? intval($put_vars['points']) : 0;
        $totalSpent = isset($put_vars['totalSpent']) ? floatval($put_vars['totalSpent']) : 0;
        
        if (empty($fullname) || empty($phone)) {
            throw new Exception('Vui lòng điền đầy đủ thông tin bắt buộc');
        }
        
        $stmt = $pdo->prepare("UPDATE customer SET 
            FullName = ?, Phone = ?, Email = ?, Gender = ?, Address = ?, Notes = ?, Points = ?, TotalSpent = ? 
            WHERE CustomerID = ?");
        $stmt->execute([$fullname, $phone, $email, $gender, $address, $notes, $points, $totalSpent, $id]);
        
        echo json_encode(['success' => true, 'message' => 'Cập nhật khách hàng thành công']);
        exit;
    }

    throw new Exception('Invalid request method');

} catch (Exception $e) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    exit;
}
?> 